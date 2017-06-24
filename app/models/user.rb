class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  has_many :tweets

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
