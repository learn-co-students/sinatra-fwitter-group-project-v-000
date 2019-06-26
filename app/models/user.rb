
class User < ActiveRecord::Base
    
    # sets the relationship so that a user has many tweet objects
    has_many  :tweets 
  
    # uses the bycrypt gem to salt a users password into a hash
    has_secure_password
  
    def slug
      username.downcase.gsub(" ","-")
    end
  
    def self.find_by_slug(slug)
      User.all.find{|user| user.slug == slug}
    end
  
  end