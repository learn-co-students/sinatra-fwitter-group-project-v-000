class User < ActiveRecord::Base
  extend Slugify::ClassMethod
  include Slugify::InstanceMethod

  has_secure_password

  has_many :tweets
end
