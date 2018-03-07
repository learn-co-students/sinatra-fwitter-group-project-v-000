class User < ActiveRecord::Base
  has_many :tweets

   # User has a secure password
   has_secure_password

# User can slug the username
  def slug
    username.downcase.gsub(" ","-")
  end

# User can find a user based on the slug
  def self.find_by_slug(slug)
      self.all.find{|user| user.slug == slug}
  end
    end
