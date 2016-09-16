
class User < ActiveRecord::Base
  has_many :tweets
  
  extend Sluggify::ClassMethods
  include Sluggify::InstanceMethods
end
