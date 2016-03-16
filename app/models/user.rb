class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    self.name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    name = slug.gsub("-", " ")
    self.find_by(name: name)
  end

end