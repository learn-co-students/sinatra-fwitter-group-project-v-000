class Tweet < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :user

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end
