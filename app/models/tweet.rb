class Tweet < ActiveRecord::Base
  #content
  belongs_to :user
end
