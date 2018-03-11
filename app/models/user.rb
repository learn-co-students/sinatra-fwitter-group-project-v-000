class User < ActiveRecord::Base
	validates_presence_of :username, :email, :password
	has_many :tweets
	has_secure_password
	include Slugify
end