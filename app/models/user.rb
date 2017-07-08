class User < ActiveRecord::Base
  validates_presence_of :username, :email, presence: true
  has_secure_password
  has_many :tweets

  extend Parser::ClassMethods
  include Parser::InstanceMethods
end
