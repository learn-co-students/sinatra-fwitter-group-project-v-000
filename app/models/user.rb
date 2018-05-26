class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password
    validates_presence_of :username, :email, :password
    
    def self.find_by_slug(slug)
      self.all.find{|x| x.slug == slug}
    end
    
    def slug
      self.username.downcase.gsub(" ","-")
    end
end