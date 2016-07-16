class User < ActiveRecord::Base

  # has a secure password
  has_secure_password
  
  has_many :tweets

  # can slug the username
  def slug
    self.username.downcase.gsub(" ", "-")
  end

  # can find a user based on the slug
  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug}
  end

end
