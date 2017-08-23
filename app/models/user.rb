class User < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods

  has_secure_password
  validates :username, :email, presence: true
  has_many :tweets
end
