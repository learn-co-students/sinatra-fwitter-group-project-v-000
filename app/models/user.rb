class User < ActiveRecord::Base

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_many :tweets
  validates :username, presence: true
  has_secure_password

end