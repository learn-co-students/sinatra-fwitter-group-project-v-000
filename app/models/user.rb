class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  # Converts a username from "test 123" to "test-123"
  def slug
    username.downcase.gsub(' ', '-')
  end

  # Finds the user by the slugified version of its username
  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end