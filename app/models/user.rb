require 'bcrypt'

class User < ActiveRecord::Base

  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email

  include BCrypt

   def slug 
    self.username.gsub(" ", "-")
  end

  def self.unslug(slug)
    slug.gsub("-", " ")
  end

  def self.find_by_slug(slug)
    User.find_by(username: self.unslug(slug))
  end


end