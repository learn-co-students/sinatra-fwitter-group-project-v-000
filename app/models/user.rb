class User < ActiveRecord::Base
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_many :tweets

  validates_presence_of :username, :email, :password

end