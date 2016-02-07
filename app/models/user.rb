class User < ActiveRecord::Base
  include Slugify

  has_many :tweets

  validates_presence_of :username, :email, :password

end