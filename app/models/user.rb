class User < ActiveRecord::Base
    #validates_presence_of :name, :email, :password
    has_secure_password
    has_many :tweets

    def slug 
        username.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        User.all.find {|username| username.slug == slug }
    end
end
