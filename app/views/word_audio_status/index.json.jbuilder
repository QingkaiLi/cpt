json.array!(@word_audio_statuses) do |was|
  json.extract! was, :spelling, :audio_id, :enabled, :created_at, :updated_at, :user_id, :audio_status_id, :description, :num, :color
  json.url word_audio_status_index_url(was, format: :json)
end