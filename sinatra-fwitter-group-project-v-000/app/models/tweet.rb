class Tweet < ActiveRecord::Base
  #  include Slugified::InstanceMethods
  #  extend Slugified::ClassMethods

belongs_to :user

end
