require_relative './concerns/slugifiable.rb'

class Tweet < ActiveRecord::Base
  belongs_to :user
  
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end