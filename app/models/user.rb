class User < ActiveRecord::Base
    has_secure_password
    has_many :tweets

    def slug 
        self.username.gsub(" ","-")
    end 

    def self.find_by_slug(slug)
        self.all.detect{|user| user.slug == slug}
    end 

    def self.current_user(session_hash)
        @current_user = self.find_by(id: session_hash[:user_id])
    end 

    def self.is_logged_in?(session_hash)
       !!session_hash[:user_id]
    end 
end 