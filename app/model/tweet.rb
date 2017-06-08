class Tweet < ActiveRecord::Base
   belongs_to :user
   include Helpers::InstanceMethods
end
