class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_secure_password 

  validates_presence_of :username, :email, :password
  
end