class ContentType < ActiveRecord::Base
  has_many :content_packs
  validates :name, :presence => true, :uniqueness => true
end
