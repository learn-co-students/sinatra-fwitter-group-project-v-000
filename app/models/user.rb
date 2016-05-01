class User < ActiveRecord::Base
	include Slugifiable::InstanceMethods
	has_many :tweets
	has_secure_password

	validates :email, :presence => true
	validates :username, :presence => true
	
	def self.find_by_slug(slug)
			self.all.detect{|name| name.slug == slug}
	end
end
