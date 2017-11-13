class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password


  #need slug methods here
  #plus macro for password


end
