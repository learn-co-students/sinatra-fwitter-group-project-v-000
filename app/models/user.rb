class User < ActiveRecord::Base
	include Slugifiable::InstanceMethods
	extend Slugifiable::ClassMethods

	has_secure_password
	validates :username, uniqueness: true
	has_many :tweets
end
