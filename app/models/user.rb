require_relative './concerns/slugifiable.rb'

class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates_presence_of :username, :email, :password_digest

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end
