class User < ActiveRecord::Base
  has_secure_password 
  
  has_many :tweets
  
  validates :username, presence: true
  validates :email, presence: true 
  
  def slug 
    username.gsub(" ", "-").downcase
  end 
  
  def self.find_by_slug(slug)
    User.all.detect {|user| user.username.downcase == slug.gsub("-", " ")}
  end 
end 


