class User < ActiveRecord::Base
	include Slugfindable::InstanceMethods
	extend Slugfindable::ClassMethods
	has_secure_password
	has_many :tweets
end 