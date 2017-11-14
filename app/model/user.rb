class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password

    def slug
        self.username.gsub(/[^a-zA-Z0-9]/,"-")
    end

    def self.find_by_slug(slug)
        self.all.find do |user|
            user.slug == slug
        end
    end
end