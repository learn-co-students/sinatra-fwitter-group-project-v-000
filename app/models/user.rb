class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    User.find_by {|user| user.slug == slug }
  end
end
