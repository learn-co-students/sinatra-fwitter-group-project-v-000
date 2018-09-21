class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  # validates_presence_of :username, :password, :email

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.select do |user|
      user.slug == slug
    end[0]
  end
end
