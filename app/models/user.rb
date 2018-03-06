class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_secure_password
  validates :username, :email, :password, presence: true
  has_many :tweets

end
