class User < ActiveRecord::Base

  has_many :tweets
  has_secure_password

  validates :username, :email, presence: true

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end
