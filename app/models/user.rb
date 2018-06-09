require_relative 'concerns/persistable'

class User < ActiveRecord::Base
  include Persistable::InstanceMethods
  extend Persistable::ClassMethods

  validates_presence_of :username, :email, :password
  has_secure_password

  has_many :tweets
end