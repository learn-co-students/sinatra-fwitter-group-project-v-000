
class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  extend Sluggify::ClassMethods
  include Sluggify::InstanceMethods
end
