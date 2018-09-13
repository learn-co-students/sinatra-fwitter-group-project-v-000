class Tweet < ActiveRecord::Base
  # binding.pry 
  belongs_to :user
end
