class User < ActiveRecord::Base
  extend Slugifiable
  include Slugifiable
  has_many :tweets

  has_secure_password
end