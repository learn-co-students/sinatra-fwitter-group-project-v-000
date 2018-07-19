class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  include Slug::InstanceMethods
  extend Slug::ClassMethods
end
