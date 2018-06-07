class User < ActiveRecord::Base
    has_many :tweets 
    has_secure_password
    
    def slug
      self.username.gsub(/\s/, "-").downcase
    end 
    
    def self.find_by_slug(slug)
      self.all.find do |u|
        u.slug == slug 
      end 
    end 
    
end 
