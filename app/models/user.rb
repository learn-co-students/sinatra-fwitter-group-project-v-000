class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end