class Tweet <ActiveRecord::Base
  belongs_to :user 
    include Sluggable::InstanceMethods
  extend Sluggable::ClassMethods
end 