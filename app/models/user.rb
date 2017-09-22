class User < ActiveRecord::Base
    has_secure_password
    has_many :tweets

    def slug
        Slugify.slug(self.username)
    end

    def self.find_by_slug(slugged_username)
        self.all.select do |user|
            user.slug==slugged_username
        end.first
    end
end