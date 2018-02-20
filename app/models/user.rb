class User < ActiveRecord::Base
	validates_presence_of :username, :email, :password
	has_secure_password

	has_many :tweets

	def slug
	  self.username.gsub(" ", "-")
	end

	def self.find_by_slug(username)
	  self.find_by(:username => username.gsub("-", " "))
	end
end