class User < ActiveRecord::Base
  has_many :tweets 
  
  has_secure_password 
  
  def slug 
    @slug = self.username.split(" ").join("-")
    #binding.pry
    @slug 
  end 
  
  def self.find_by_slug(slug)
    not_slug = slug.split("-").join(" ")
    #binding.pry
    @user = User.find_by(:username => not_slug) 
  end 
end 