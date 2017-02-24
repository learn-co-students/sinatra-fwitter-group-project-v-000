class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :password, :email
end
