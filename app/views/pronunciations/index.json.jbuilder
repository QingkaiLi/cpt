json.array!(@pronunciations) do |pronunciation|
  json.extract! pronunciation, 
  json.url pronunciation_url(pronunciation, format: :json)
end
