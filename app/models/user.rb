class User < ActiveRecord::Base
  validates :username, presence: true
  has_secure_password
  has_many :tweets
end
