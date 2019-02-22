require_relative '../models/concerns/slugifiable'

class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  
  attr_accessor :name
  
  has_secure_password
  has_many :tweets
  
  
end