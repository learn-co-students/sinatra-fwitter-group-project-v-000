class User < ActiveRecord::Base
  # has_secure_passord is a macro working in conjunction with bcript gem that secures passwords.
  # Access password_digest in database through pasword attribute. has_secure_password makes this conversion automatically.
  has_secure_password

  has_many :tweets
end
