class User < ActiveRecord::Base

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
  has_secure_password

end