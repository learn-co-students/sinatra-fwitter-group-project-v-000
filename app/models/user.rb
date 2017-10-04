class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username
  validates_presence_of :email
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
