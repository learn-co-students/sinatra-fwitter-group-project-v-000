class User < ActiveRecord::Base 

 has_secure_password 
 has_many :tweets 

 

 def slug
    
    self.username.gsub(" ", "-").downcase

 end 


 def self.find_by_slug(slug)
     
     self.all.each do |user|
        if user.slug == slug 
          return user 
        end 
     end 
 end 


 def current_user 
    self.find_by_id(session[:id])
 end 

 def self.is_logged_in
    if session[:id] != nil 
      true 
    else 
      false
    end 

 end 


end 