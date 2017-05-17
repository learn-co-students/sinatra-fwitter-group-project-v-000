class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  validates :password, length: { minimum: 8}

end
