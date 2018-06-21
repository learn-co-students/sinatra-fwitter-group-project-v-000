class User < ActiveRecord::Base

  has_secure_password

  has_many :tweets

  validates :username, :password, presence: true

end
