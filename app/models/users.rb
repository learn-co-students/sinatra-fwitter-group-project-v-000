
class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  extend Sluggify::ClassMethods
  include Sluggify::InstanceMethods

end
