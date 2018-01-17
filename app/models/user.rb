class User < ActiveRecord::Base
attr_accessor :password_digest
  has_many :tweets

  has_secure_password
end
