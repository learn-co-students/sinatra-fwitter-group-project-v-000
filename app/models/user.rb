class User < ActiveRecord::Base 
    has_many :tweets
    has_secure_password

    def slug
        self.username.gsub(" ", "-").downcase
    end

    def self.find_by_slug(slug)
        all.detect{|i| i.slug == slug}
    end


end