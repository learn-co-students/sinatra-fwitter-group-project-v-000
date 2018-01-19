class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  include Slugable::InstanceMethods
  extend Slugable::ClassMethods
end
