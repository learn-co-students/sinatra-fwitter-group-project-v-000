class User < ActiveRecord::Base
    has_many :tweets
    validates_presence_of :username, :email, :password
    validates_uniqueness_of :username 
    has_secure_password

    def slug
        self.username.gsub(/\s+/, '-')
    end

    def self.find_by_slug(slug)
        self.all.find do |user|
            user.slug == slug
        end
    end

end