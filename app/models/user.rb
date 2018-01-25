class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :username, :password, :email
	has_many :tweets

	def slug
		slugged = self.username.split(" ")
		slugged.join("-")
	end

	def self.find_by_slug(slug)
		User.find_by_username(slug.split("-").join(" "))
	end
end