class User < ActiveRecord::Base
	has_many :tweets
	has_secure_password
	validates_presence_of :username, :email, :password

	def slug
		self.username.gsub(" ", "-").downcase
	end

	def self.find_by_slug(slug)
		name = slug.gsub("-", " ")
		User.all.each do |user|
			if user.username == name
				return User.find(user.id)
			end
		end
	end
end