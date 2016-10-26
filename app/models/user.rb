class User < ActiveRecord::Base
    validates :username, :email, presence: true
    has_many :tweets

    has_secure_password

    def slug
        self.username.parameterize
    end

    def self.find_by_slug(slug)
        self.all.map do |user|
            if user.slug == slug
                return user
            end
        end
    end

end
