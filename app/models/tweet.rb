class Tweet < ActiveRecord::Base
  belongs_to :user
  #  u.tweets.create(content: "Content")
end
