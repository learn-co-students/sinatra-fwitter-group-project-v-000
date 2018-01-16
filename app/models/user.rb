class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  extend  Useful::ClassMethods
  include Useful::InstanceMethods
end
