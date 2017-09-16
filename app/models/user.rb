class User < ActiveRecord::Base
  
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :password, :email

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end
end
