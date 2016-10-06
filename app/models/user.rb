class User < ActiveRecord::Base
has_many :tweets

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def authenticate(password)
    if self.password == password
      self
    else
      false
    end
  end

  def self.find_by_slug(slug)
    User.all.detect do |user|
      user.slug == slug
    end
  end
end
