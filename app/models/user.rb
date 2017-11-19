class User < ActiveRecord::Base
    has_secure_password
    has_many :tweets

    def self.find_by_slug(slug)
      User.all.detect {|user| user.slug == slug }
    end

    def slug
      self.username.gsub(" ", '-').downcase
    end
  end
