class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :email, :password
end