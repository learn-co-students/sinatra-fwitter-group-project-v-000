class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  has_many :tweets

  def slug
    self.username.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, "")
  end

  def self.find_by_slug(slug)
    User.all.detect { |user| user.slug == slug }
  end
end
