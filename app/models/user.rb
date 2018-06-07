class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password
  has_secure_password

  # make sure that our user fill_in those pieces... email, password etc.
  has_many :tweets
end
