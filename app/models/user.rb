class User < ActiveRecord::Base
	has_secure_password
	has_many :tweets

	def slug
		word_ = self.username.downcase
		word_ = word_.sub(/[ ]/, '-')
		word_  
	end
	
	def self.find_by_slug(slug)
		uid = slug.sub(/[-]/, ' ')
		User.find_by(username: uid)
	end
end
