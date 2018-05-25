class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password
    
    def slug
        lowercase = self.username.downcase
        arr = lowercase.split
        stripped = arr.collect { |x| x.match(/[a-z0-9]*/) }
        stripped.join("-")
    end

    def self.find_by_slug(slug)
        arr = slug.split("-")
        slug_name = arr.join(" ")
        self.where(name == slug_name).last
    end

end