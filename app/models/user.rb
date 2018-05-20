class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :tweets


  def slug
    self.username.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    search = slug.split("-").join(" ")
    User.find_by_username(search)
  end
end
