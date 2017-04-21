class User < ActiveRecord::Base
  extend Sluggable::ClassMethods
  include Sluggable::InstanceMethods
  
  has_many :tweets
  has_secure_password

end
