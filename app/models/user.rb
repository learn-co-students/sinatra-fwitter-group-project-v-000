class User < ActiveRecord::Base
  has_many :tweets

  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_secure_password
end
