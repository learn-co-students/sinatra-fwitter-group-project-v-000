class User < ActiveRecord::Base
  include Slugifiable
  has_many :tweets
  has_secure_password
end