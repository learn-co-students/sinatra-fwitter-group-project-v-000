class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password


    def slug
      self.username.split(" ").join("-").downcase
    end

    def self.find_by_slug(slug)
      all_users = User.all
      user = all_users.find do |user|
                user.slug == slug
              end
      return user
    end

end
