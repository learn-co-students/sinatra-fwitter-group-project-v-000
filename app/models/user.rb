class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  validates :username, :password, :email, presence: true

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.find_by(:username => slug.gsub("-", " "))
  end
end
