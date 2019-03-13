class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password
    validates_presence_of :username, :email

    extend Slugifiable
    include Slugifiable::InstanceMethods
end