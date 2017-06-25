class User < ActiveRecord::Base
	has_seccure_password
	has_many :tweets
end 