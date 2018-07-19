class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password
    validates :email, :presence => true
    validates :username, :presence => true

end