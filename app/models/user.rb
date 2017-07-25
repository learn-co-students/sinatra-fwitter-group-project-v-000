class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username
  has_many :tweets
end
