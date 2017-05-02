class User < ActiveRecord::Base

  has_secure_password
  has_many :tweets

  validates :username, :email, :password_digest, :presence => true

  def slug
    username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    User.all.find {|instance| instance.slug == slug}
  end

end
