class User < ActiveRecord::Base
    include Slugifiable

    has_secure_password
    validates :username, :password, :email, presence: true
    has_many :tweets
end