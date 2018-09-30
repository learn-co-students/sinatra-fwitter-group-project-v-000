class User< ActiveRecord::Base
  
  has_many :tweets
  has_secure_password
  # has a secure password
  validates_presence_of :username, :email, :password

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end