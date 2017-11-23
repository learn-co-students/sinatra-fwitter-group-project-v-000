class User < ActiveRecord::Base
has_many :tweets
has_secure_password
validates_presence_of :username
validates_uniqueness_of :username
validates_presence_of :password
validates_presence_of :email

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.detect do |user|
      user.slug == slug
    end
  end
end
