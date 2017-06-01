class User < ActiveRecord::Base
  validates_presence_of :username, :email

  has_secure_password
  has_many :tweets

  def slug
    self.username.strip.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.detect{ |user| user.slug == slug }
  end
end
