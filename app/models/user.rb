class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username 
  validates_presence_of :email
  validates_presence_of :password
  has_many :tweets

      def slug
        self.username.downcase.gsub(" ", "-")
      end

      def self.find_by_slug(slug)
        User.all.find do |user|
          user.slug == slug
        end
      end
end
