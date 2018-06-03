class User < ActiveRecord::Base 
  has_many :tweets
  has_secure_password 
  
 
  def self.find_by_slug(slug)
    self.all.detect{|o| o.slug == slug}
  end 
  
  def slug 
    username_arr = self.username.split(" ")
    username_arr.collect{|w| w.downcase}.join('-')
  end
   
end 