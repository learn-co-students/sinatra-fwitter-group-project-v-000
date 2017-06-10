class User < Sinatra::Base
  extend Parser::ClassMethods
  include Parser::InstanceMethods
  
  has_many :tweets
  validates :username, :email, presence: true
  has_secure_password
end
