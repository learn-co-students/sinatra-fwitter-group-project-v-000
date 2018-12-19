class User < ActiveRecord::Base
  has_secure_password
  #Users should have a username, email, and password, and have many tweets.
  has_many :tweets

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    User.all.find{|u| u.slug == slug}
  end


end
