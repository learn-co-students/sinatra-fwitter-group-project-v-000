class User < ActiveRecord::Base
  include Slugifiable
  extend Findable

  has_secure_password
  has_many :tweets
end
