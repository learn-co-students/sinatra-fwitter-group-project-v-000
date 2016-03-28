class User < ActiveRecord::Base

  has_many :tweets
  has_secure_password
  validates_presence_of :username, :password, :email

  def slug
    self.username.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    User.find_by(username: slug.split("-").join(" "))
  end
end

