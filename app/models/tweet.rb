class Tweet < ActiveRecord::Base
  belongs_to :user

  # def self.find_by_id(id)
  #   Tweet.all.find{|tweet| tweet.id == id}
  # end
end
