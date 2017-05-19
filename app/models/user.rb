class User < ActiveRecord::Base
  has_many :tweets
  validates :username, :email, presence: true
  has_secure_password
end
