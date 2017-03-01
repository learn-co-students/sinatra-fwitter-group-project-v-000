require_relative './concerns/slugifiable.rb'

class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end
