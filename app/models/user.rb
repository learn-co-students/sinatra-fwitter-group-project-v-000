class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    name = slug.gsub("-", " ")
    self.find_by(username: name)
  end

end