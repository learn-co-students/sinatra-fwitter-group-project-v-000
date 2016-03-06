require 'pry'
class User < ActiveRecord::Base

  has_many :tweets

  validates_presence_of :username, :email, :password
  has_secure_password

  def slug
    slugify(username)
  end

  def slugify(username)
    username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.all.detect do |user|
      user.username.downcase == slug.split("-").join(" ")
    end
  end

  # def self.new_valid_user(params)
  #   if !User.find_by(username: params[:username]) || !User.find_by(email: params[:email])
  #     user = User.new(params)
  #   else
  #     user = User.new
  #   end
  # end

end