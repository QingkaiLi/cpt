class ContentPack < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :content_type_id, :presence => true
  validates :status_id, :presence => true
  validates :name, :presence => true, :uniqueness => true, :length => {:maximum => 256}
  validates :description, :length => {:maximum => 1024}
  
  # Notice: before_* filters must before associations 
  before_validation :set_association_value
  before_create :create_default_topic
  before_destroy :ensure_content_pack_is_empty
  # after_destroy :destroy_associated_topics
  
  belongs_to :status
  belongs_to :content_type
  belongs_to :user
  has_many :topics, dependent: :destroy
  
  default_scope {order("updated_at desc")}
  
  STATUS_PUBLISHED = "Published"
  
  def published?
    status.name.eql? STATUS_PUBLISHED
  end
  
  def empty?
    topics.reduce(true) {|empty, t| empty &&= t.empty?}
  end

  def max_priority
    topics.maximum :priority
  end
  
  def create_default_topic
    topics.build name: Topic.generate_def_name, grade_level: 1, default: true, priority: 0
  end
  
  def default_topic
    topics.find_by_default true
  end
  
  private
    def set_association_value
      self.status ||= Status.first
      self.content_type ||= ContentType.first
    end
    
    def ensure_content_pack_is_empty
      unless empty?
        errors.add(:error, I18n.t('content_packs.controller.delete.failed', name: self.name))
        false
      end
    end

    def destroy_associated_topics
      topics.destroy_all
    end
end
