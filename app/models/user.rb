class User < ActiveRecord::Base
  has_many :tweets
  extend Slugable::ClassMethods
  include Slugable::InstanceMethods
end
