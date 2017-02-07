class Tweet < ActiveRecord::Base
  include Concerns::InstanceMethods
  extend Concerns::ClassMethods
  
  belongs_to :user
end