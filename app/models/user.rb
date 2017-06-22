class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :email, on: :create
  validates_presence_of :username, on: :create
  validates_presence_of :password, on: :create
end
