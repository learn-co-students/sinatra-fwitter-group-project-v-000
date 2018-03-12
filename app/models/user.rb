require 'bcrypt'

class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  include BCrypt
  has_secure_password
  has_many :tweets
end
