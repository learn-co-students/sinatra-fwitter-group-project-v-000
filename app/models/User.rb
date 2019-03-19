require_relative 'concerns/slugifiable'

class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_many :tweets
  has_secure_password
end
