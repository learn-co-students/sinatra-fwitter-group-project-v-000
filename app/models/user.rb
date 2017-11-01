class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :email, :password

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    user_name = slug.gsub("-", " ").upcase
    self.all.detect {|user| user.username.upcase == user_name}
  end

end
