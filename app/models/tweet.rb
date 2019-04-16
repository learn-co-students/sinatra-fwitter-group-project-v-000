class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :tweets
  # has_many :user_tweets



end
