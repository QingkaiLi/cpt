class Selection < ActiveRecord::Base
  validates :topic_id, :presence => true
  validates :status_id, :presence => true
  validates :updater_id, :presence => true
  validates :description, :length => {:maximum => 1024}
  validates :title, :presence => true, :length => {:maximum => 256}, uniqueness: {if: :title_must_be_unique_within_content_pack?}
  validates :grade_equivalent_level, :presence => true
  validates :wcpm_target, :numericality => { less_than: 1000, greater_than: 0, only_integer: true}, allow_blank: true
  validates :author, :length => {:maximum => 256}
  validates :illustrator, :length => {:maximum => 256}
  validates :publisher, :length => {:maximum => 256}
  # validates :cover_image
  validates :intro_audio, :length => {:maximum => 1024}
  validates :intro_text, :length => {:maximum => 1024}
  validates :internationally, :inclusion => {:in => [true, false]}
  
  before_validation :set_init_value
  before_save :ensure_content_pack_is_not_published
  before_create :init_priority
  before_destroy :ensure_content_pack_is_not_published

  belongs_to :topic
  belongs_to :status
  belongs_to :updater, class_name: "User"
  
  default_scope {order("selections.priority DESC")}
  
  GRADE_EQUIVALENT_LEVEL = ['NP'] + (10...40).map {|v| v/10.0} + (4..12).to_a
  LEXILE_LEVEL = ['NP'] + 200.step(1299, 50).map {|i| "#{i}~#{i+49}L"} << '1300L'
  GUIDED_READING_LEVEL = ['NP'] + ("D".."Z").to_a
  
  # Move current selection to other ContentPack
  #
  # User can move selection to a unPublished ContentPack, but cannot be moved to
  # the same ContentPack it is currently in
  #
  # ==== Args   :
  # * +to_content_pack+ - which ContentPack selection will be moved to
  # * +new_title+ - new Selection title, if nil, the new title default is 
  # ==== Raises :
  # * +ActiveRecord::RecordInvalid+ cannot move to ContentPack which already has
  #   the same name Selection
  # ==== Return :
  #
  def move_to(to_content_pack, new_title)
      Selection.transaction do
        to_default_topic = ContentPack.find(to_content_pack).default_topic
        to_priority = to_default_topic.max_priority + 1
        
        ordering_between_topics(self.topic, to_default_topic, self.priority, to_priority)
        self.topic = to_default_topic
        self.update_attributes!(priority: to_priority, title: new_title || self.title)
      end
    rescue ActiveRecord::RecordInvalid => e
      false
  end
  
  def copy_to(to_content_pack, new_title)
      default_topic = ContentPack.find(to_content_pack).default_topic
      new_sel = Selection.new self.attributes.merge(id: nil, title: new_title||self.title)
      new_sel.topic = default_topic
      new_sel.save!
    rescue ActiveRecord::RecordInvalid => e
      #logger.error('')
    ensure
      return new_sel
  end
  
  # Move current selection to specified location, and other selections' location within the same
  # content pack will be updated automatically by sequence
  #
  # User orders selections through drag/drop Selection rows within one Topic or through different
  # Topics. we use <tt>priority</tt> in database to indicate their orders within Topic.
  #
  # ==== Args   :
  # * +to_topic_id+ - which Topic selection will be moved to
  # * +to_priority+ - the location in one Topic selection will be moved to
  # ==== Raises :
  # * ActiveRecord::Rollback
  #
  def ordering(to_topic_id, to_priority)
    to_topic = Topic.find to_topic_id
    
    Selection.transaction do
      if topic == to_topic
        ordering_within_topic(topic, self.priority, to_priority)
      else
        ordering_between_topics(topic, to_topic, self.priority, to_priority)
      end
      self.update!(priority: to_priority, topic_id: to_topic.id)
     end
  end
  
  private
    def ordering_within_topic(topic, from_priority, to_priority)
      if from_priority < to_priority
        topic.selections.where("priority <= ? and priority > ?", to_priority, from_priority).each {
          |sel| sel.update_attributes!(:priority => sel.priority - 1)
        }
      else
        topic.selections.where("priority >= ? and priority < ?", to_priority, from_priority).each {
          |sel| sel.update_attributes!(:priority => sel.priority + 1)
        }
      end
    end
    
    def ordering_between_topics(from_topic, to_topic, from_priority, to_priority)
      from_topic.selections.where("priority > ?", from_priority).each {
        |sel| sel.update_attributes!(:priority => sel.priority - 1)
      }
      to_topic.selections.where("priority >= ?", to_priority).each {
        |sel| sel.update_attributes!(:priority => sel.priority + 1)
      }
    end
  
    def set_init_value
      self.status ||= Status.first
    end
    
    def init_priority
      self.priority = topic.max_priority + 1
    end
    
    def ensure_content_pack_is_not_published
      content_pack = topic.content_pack
      if content_pack && content_pack.published?
        errors.add :error, I18n.t('content_packs.controller.update.failed', name: content_pack.name)
        false
      end
    end
    
    def title_must_be_unique_within_content_pack?
      Selection.where.not(id: self.id).includes(:topic).where(title: title, topics: {content_pack_id: topic.content_pack_id}).exists?
    end
end
