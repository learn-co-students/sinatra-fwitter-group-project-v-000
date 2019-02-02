class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.downcase.gsub(/\s+/, "-")
  end

  def self.find_by_slug(slug)
    slug = slug.gsub("-", " ")
    User.find_by(username: slug)
  end
end
