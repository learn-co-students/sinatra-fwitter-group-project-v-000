class User < ActiveRecord::Base
	validates :username, presence: true
	validates :email, presence: true
	has_many :tweets
	has_secure_password

	def slug
		self.username.parameterize
	end

	def self.find_by_slug(my_slug)
		self.all.detect do |user|
			user.slug == my_slug
		end
	end
end