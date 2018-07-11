class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  
  extend Slug::ClassMethods
  include Slug::InstanceMethods

end
