class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :username, :password_digest
	has_many :tweets

	def slug
		self.username.parameterize('-')
	end

	def self.find_by_slug(slug)
		User.all.find do |user|
			user.slug == slug
		end
	end
end