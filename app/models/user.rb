class User < ActiveRecord::Base
	has_many :tweets
	validates_presence_of :username
	validates_presence_of :email
	validates_presence_of :password
	has_secure_password

	def slug
		slug = username.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		User.all.detect { |user| user.slug == slug }
	end
end