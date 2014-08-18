json.array!(@topics) do |topic|
  json.extract! topic, :name, :grade_level, :defalut
  json.url topic_url(topic, format: :json)
end
