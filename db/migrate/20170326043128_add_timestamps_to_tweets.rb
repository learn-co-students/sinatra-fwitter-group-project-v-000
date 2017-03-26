class AddTimestampsToTweets < ActiveRecord::Migration
  def change
    add_timestamps(:tweets)
  end
end
