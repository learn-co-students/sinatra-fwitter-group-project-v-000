class User < ActiveRecord::Base
  has_many :tweets
  
  has_secure_password
  def slug
    username.downcase.gsub(" ","-") # @username doesn't work
  end
  
  def self.find_by_slug(slug)
    User.all.find { |user| user.slug == slug }
  end
  
end
