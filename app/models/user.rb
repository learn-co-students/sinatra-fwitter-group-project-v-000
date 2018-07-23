class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password
    validates :email, :presence => true
    validates :username, :presence => true

    def self.find_by_slug(slug)
        User.all.detect {|user| user.slug == slug}
    end

    def slug
        self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

end