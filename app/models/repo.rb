class Repo < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :stargazers_count, presence: true
  validates :forks_count, presence: true

  def self.public
    where(public: true)
  end
end
