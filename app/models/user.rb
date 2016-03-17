class User < ActiveRecord::Base
  include Slugifiable::InstanceMehods
  extend Slugifiable::ClassMethods
  
  has_many :tweets
  has_secure_password
end
