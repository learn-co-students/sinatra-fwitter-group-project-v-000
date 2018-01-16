class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :usertweets
end