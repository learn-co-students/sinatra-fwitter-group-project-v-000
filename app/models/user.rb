class User < ActiveRecord::Base
	has_many :tweets
	has_secure_password
	def slug
		self.username
	end
end