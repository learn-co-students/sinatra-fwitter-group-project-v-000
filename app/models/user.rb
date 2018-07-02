class User < ActiveRecord::Base
	has_many :tweets
	has_secure_password

	def slug
		slug = self.username.gsub(" ","-").downcase
	end
	

	def self.find_by_slug(slug)
		self.all.find {|t| t.slug == slug}
	end

end
