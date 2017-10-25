require_relative "../helpers/support_modules"

class User < ActiveRecord::Base
  include Slugs

  has_secure_password
  validates_presence_of :username, :email, :password

  has_many :tweets
end