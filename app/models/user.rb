class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password
    validates_presence_of :username, :email, :password
    include Slugger::InstanceMethods
    extend Slugger::ClassMethods
end