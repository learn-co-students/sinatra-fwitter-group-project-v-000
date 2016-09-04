class User < ActiveRecord::Base
  has_many :tweets

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end