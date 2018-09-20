class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :password, :email
  
  def slug
    self.username.gsub(" ","-").downcase
  end
  
  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end
end