class Tweet < ActiveRecord::Base
  belongs_to :user

  include Slugifiable::InstanceMethod
  extend Slugifiable::ClassMethod
end
