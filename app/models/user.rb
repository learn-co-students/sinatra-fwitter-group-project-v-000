class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  
  has_many :tweets

  def slug
    username.to_s.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |name|
      name.slug == slug 
    end
  end
end