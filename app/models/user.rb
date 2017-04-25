class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email,  presence: true
  has_secure_password

  has_many :tweets

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end
