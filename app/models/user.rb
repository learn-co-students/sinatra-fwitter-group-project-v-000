class User < ActiveRecord::Base

  extend Concerns::Slugifiable::ClassMethods
  include Concerns::Slugifiable::InstanceMethods

  def authenticate(password)
    password == self.password ? self : false
  end
  has_many :tweets



end
