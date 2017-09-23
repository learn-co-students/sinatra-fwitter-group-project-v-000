class User < ActiveRecord::Base
    has_secure_password
    validates :username, :email, :password, presence: true
    has_many :tweets

    def slug
        self.username.split.join("-")
    end

    def self.find_by_slug(slugged_username)
        self.all.select do |user|
            user.slug==slugged_username
        end.first
    end
end