class User < ActiveRecord::Base
  include Slugifiable
  validates :username, :email, presence: true
  has_secure_password
  has_many :tweets
end
