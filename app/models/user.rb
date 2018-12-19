class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.gsub(" ", "-")
  end

  def authenticate(password)
    if password == self.password
      self
    else
      false
    end
  end

  def self.find_by_slug(slug)
    User.find_by(username: slug.gsub("-", " "))
  end
end
