class Topic < ActiveRecord::Base
  validates :content_pack_id, :presence =>true
  validates :name, :presence => true, uniqueness: { scope: :content_pack_id }, :length => {:maximum => 256}
  validates :grade_level, :format => { :with => /\A\d+??(?:\.\d{0,2})?\z/}, :presence => true, :numericality => { less_than: 101, greater_than_or_equal_to: 1}
  validates :default, :inclusion => {:in => [true, false]}

  before_validation :set_init_value
  before_save :ensure_content_pack_is_not_published
  before_create :move_selections_to_first_topic
  before_destroy :ensure_content_pack_is_not_published
  before_destroy :ensure_topic_is_empty
  
  has_many :selections
  belongs_to :content_pack
  
  default_scope {order("topics.default DESC, priority DESC")}
  
  def self.generate_def_name
    def_name = "default_topic_";
    50.times{ def_name << ((rand(2)==1?65:97) + rand(25)).chr }
    def_name
  end
  
  def max_priority
    selections.maximum(:priority) || -1
  end
  
  def empty?
    selections.empty?
  end
  
  def total_selections
    selections.size
  end
  
  # Move current topic to specified location, and other topics' location within the same
  # content pack will be updated automatically by sequence
  #
  # User orders topics through drag/drop Topic rows, we use <tt>priority</tt> in database
  # to indicate their orders within ContentPack
  #
  # * *Args*   :
  #   - +to_priority+ - the location current topic will be moved to
  # * *Rails*   :
  #   - ActiveRecord::Rollback
  #
  def ordering(to_priority)
    Topic.transaction do
      if self.priority < to_priority
        content_pack.topics.where("priority <= ? and priority > ?", to_priority, self.priority).each {
          |topic| topic.update_attributes!(:priority => topic.priority - 1)
        }
      else
        content_pack.topics.where("priority >= ? and priority < ?", to_priority, self.priority).each {
          |topic| topic.update_attributes!(:priority => topic.priority + 1)
        }
      end
      self.update_attributes!(priority: to_priority)
    end
  end
  
  private
    def set_init_value
      self.default ||= false
      self.priority ||= content_pack.nil? ? 1 : content_pack.max_priority + 1
    end

    def move_selections_to_first_topic
      if content_pack.topics.count == 1
        default_topic = content_pack.default_topic
        self.selections = default_topic.selections
      end
    end

    def ensure_topic_is_empty
      unless empty?
        errors.add(:error, I18n.t('topics.controller.delete.failed', name: self.name))
        false
      end
    end

    def ensure_content_pack_is_not_published
      if content_pack && content_pack.published?
        errors.add :error, I18n.t('content_packs.controller.update.failed', name: content_pack.name)
        false
      end
    end
end
