class User < ActiveRecord::Base
  include Concerns::InstanceMethods
  extend Concerns::ClassMethods
  validates_presence_of :username, :email, :password
  has_secure_password
  has_many :tweets
end
