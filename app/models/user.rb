class User < ActiveRecord::Base
  include Slugifiable
  extend Slugifiable 
  validates_presence_of :username, :password
  has_many :tweets
  has_secure_password
end 