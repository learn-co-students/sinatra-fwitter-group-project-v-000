class User < ActiveRecord::Base 
	has_many :tweets
	has_secure_password

	def slug
		self.username.gsub(/\ /, "-").downcase
	end

	def self.find_by_slug(slug)
		self.all.map {|info| @username = info.username if info.slug == slug}
		self.find_by(:username => @username)
	end
end