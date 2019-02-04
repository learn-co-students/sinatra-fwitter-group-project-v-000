class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  
  
  def slug
    return self.username.gsub(/[^a-zA-Z0-9]+/,'-').downcase
  end
  
  def self.find_by_slug(slug)
    User.all.find { |user| user.slug == slug }
  end
  
end