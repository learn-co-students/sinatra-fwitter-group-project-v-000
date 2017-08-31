class Tweet < ActiveRecord::Base
 
   extend Concerns::Slugifiable::ClassMethods
   include Concerns::Slugifiable::InstanceMethods
 
  belongs_to :user
 
 end
