class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password
  # validates :username, presence: true
  # validates :email, presence: true
  # validates :password, presence: true
  validates :email, uniqueness: true

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end
