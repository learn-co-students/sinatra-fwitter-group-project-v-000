class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password
  
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
