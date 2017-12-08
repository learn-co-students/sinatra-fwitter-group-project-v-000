class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.where("LOWER(username)=?", slug.gsub("-", " ")).first
  end
end
