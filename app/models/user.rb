class User < ActiveRecord::Base

  has_secure_password
  has_many :tweets

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    user = User.find_by_id(session[:user_id])
    user
  end

  def slug
    slug = self.username.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    unslugged = slug.split("-").join(" ")
    user = User.find_by(username:unslugged)
    user
  end
end