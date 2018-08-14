class Tweet < ActiveRecord::Base
  belongs_to :user

  def self.delete_all
    Tweet.all.each do |tweet|
      tweet.delete
    end
  end
end
