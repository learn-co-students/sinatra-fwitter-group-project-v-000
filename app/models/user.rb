class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    slug = username.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    name = slug.split("-").join(" ")
    User.find_by(username: name)
  end

end
