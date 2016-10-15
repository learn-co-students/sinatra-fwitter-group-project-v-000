class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  extend Slugable::ClassMethods
  include Slugable::InstanceMethods
end
