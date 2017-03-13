#require_relative './concerns/slugifiable.rb'

class Tweet < ActiveRecord::Base
  #extend Slugifiable::ClassMethods
  #include Slugifiable::InstanceMethods

  belongs_to :user
  validates :content, presence: true 

end
