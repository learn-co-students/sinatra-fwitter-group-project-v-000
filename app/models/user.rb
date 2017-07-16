class User < ActiveRecord::Base 
	has_many :tweets
	has_secure_password
	validates_presence_of :username, :email

	def slug
		self.username.downcase.strip.gsub(' ', '-')
	end 

	def self.find_by_slug(slug)
		User.all.detect do |item|
		item.slug == slug		
		end	
	end
end 