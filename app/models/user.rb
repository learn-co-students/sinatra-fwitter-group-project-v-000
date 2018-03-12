class User < ActiveRecord::Base
  include Concerns::Slugify
  extend Concerns::Findable
  has_secure_password
  has_many :tweets
end
