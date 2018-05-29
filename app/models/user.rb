class User < ActiveRecord::Base
  validates :username, :email, presence: true
  has_secure_password
  has_many :tweets
end
