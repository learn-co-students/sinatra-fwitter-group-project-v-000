class User < ActiveRecord::Base

  has_many :tweets

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end
