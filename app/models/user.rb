class User < ActiveRecord::Base
    has_many :tweets

    def slug
        self.username.downcase.gsub(" ","-")
        #parameterize?
    end

    def self.find_by_slug(slug)
        User.all.detect {|user| user.slug == slug}
    end
end
