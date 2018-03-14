class User < ActiveRecord::Base
  include Helpers::Slugify
  extend Helpers::Findable

  has_secure_password

  has_many :tweets
end
