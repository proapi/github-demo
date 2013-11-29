class User < ActiveRecord::Base

  validates :provider, presence: true
  validates :uid, presence: true
  validates :name, presence: true
  validates :login, presence: true

  has_many :repos, -> { where public: true }, dependent: :destroy
  accepts_nested_attributes_for :repos

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.login = auth['info']['nickname']
      user.repos_url = auth['extra']['raw_info']['repos_url']
    end
  end
end
