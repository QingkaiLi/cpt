class TopicSelectionRelation < ActiveRecord::Base
  before_create :init_priority

  belongs_to :topic
  belongs_to :selection
  
  def init_priority
    self.priority = topic.max_topic_selection_relations_priority + 1
  end
end
