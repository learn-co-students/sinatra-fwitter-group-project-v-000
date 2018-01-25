class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  extend Slugable::ClassMethods
  include Slugable::InstanceMethods
  
  #validates :username, presence: true
  #validates :username, uniqueness: true
  #validates :email, presence: true
  #validates :email, uniqueness: true
end