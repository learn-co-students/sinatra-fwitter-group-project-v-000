class Tweet < ActiveRecord::Base
  #relationship
  belongs_to :user
end
