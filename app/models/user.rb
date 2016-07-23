class User < ActiveRecord::Base
  has_many :tweets

  include Slugifiable::Instance
  extend Slugifiable::Class

  def authenticate(password)
    password == self.password ? self : false
  end
end