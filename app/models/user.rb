class User < ActiveRecord::Base
  include Slugified::InstanceMethods
  extend Slugified::ClassMethods
has_secure_password
has_many :tweets

end
