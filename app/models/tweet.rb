class Tweet < ActiveRecord::Base
  belongs_to :user
  extend  Useful::ClassMethods
  include Useful::InstanceMethods
end
