class User < ActiveRecord::Base
  validates :username, :email, presence: true
  has_secure_password
end
