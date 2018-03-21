class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_secure_password
  has_many :tweets
end
