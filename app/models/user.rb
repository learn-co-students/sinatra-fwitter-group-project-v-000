class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods
  
end