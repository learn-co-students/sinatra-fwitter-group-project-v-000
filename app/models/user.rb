class User < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods

  has_many :tweets
  has_secure_password
end
