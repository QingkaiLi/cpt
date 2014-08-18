json.array!(@content_packs) do |content_pack|
  json.extract! content_pack, :name, :description, :status, :content_type, :user, :editable, :deleteable, :id
  json.url content_pack_url(content_pack, format: :json)
end
