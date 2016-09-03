class User < ActiveRecord::Base

  has_secure_password
  has_many :tweets
  validates_presence_of :email
  validates_presence_of :username
  validates_presence_of :password

  def slug
    self.username.downcase.gsub(" ", "-").gsub(/[^a-zA-Z0-9-]/, "")
  end

  def self.find_by_slug(slug) 
    self.all.find {|user| user.slug == slug}
  end

end