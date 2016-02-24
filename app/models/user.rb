class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  include Sluggable::InstanceMethods
  extend Sluggable::ClassMethods
end 