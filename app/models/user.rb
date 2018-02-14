class User < ActiveRecord::Base
  has_many    :tweets
  has_secure_password
  validates  :username, :email, :password, presence: true

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    User.where("LOWER(username) = ?", slug.gsub("-", " ").downcase).first
  end
end
