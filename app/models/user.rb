class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, :password, :email, presence: true

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end

 ##moved back to main ApplicationController
  # def self.current_user(session)
  #   @current_user ||= User.find(session[:id]) if session[:id]
  # end
end
