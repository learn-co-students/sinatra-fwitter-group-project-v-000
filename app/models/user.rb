class User < ActiveRecord::Base
	has_secure_password
	has_many :tweets

	def slug
		username.downcase.gsub(/\s+/, '-')
	end

	def self.find_by_slug(username)
		self.all.detect {|user|
			user.slug == username }
	end
	
end