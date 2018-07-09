class Tweet < ActiveRecord::Base
  belongs_to :user
  
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods
  
end