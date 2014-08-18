class User < ActiveRecord::Base
  has_many :support_cases, dependent: :destroy
  has_many :content_packs, dependent: :destroy
  has_many :selections
  validates :provider, presence: true, length: {within: 1..255}
  validates :uid, presence: true, length: {within: 1..255}, uniqueness: {scope: :provider}
  validates :name, presence: true, length: {within: 1..255}

  class << self
    def from_omniauth(auth)
      where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
    end

    def create_from_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.name = auth['info']['name'] || auth['uid']
      end
    end
  end
end
