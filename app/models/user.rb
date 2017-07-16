class User < ActiveRecord::Base
  include Concerns::InstanceMethods
  extend Concerns::ClassMethods

  has_many :tweets
  
  has_secure_password
end