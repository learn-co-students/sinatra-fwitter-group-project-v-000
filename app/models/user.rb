class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :username, :password_digest, :email
	has_many :tweets

	extend Slug::ClassMethods

	include Slug::InstanceMethods
end