module TopicsHelper
  def topic_error_notification(topic, action)
    type = topic.content_pack.published? ? 'published' : 'not_empty'
    I18n.t "topics.controller.#{action}.failed.#{type}", name: topic.name
  end

  # empty when content pack only has default topic and no selection
  def empty? (topics)
    (topics.size == 1 && topics[0].selections.size == 0) || @topics.size == 0
  end
end
