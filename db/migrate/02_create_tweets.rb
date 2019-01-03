class CreateTweets < ActiveRecord::Migration

  def change
    create_table :tweets do |tweet|
      tweet.text :content
      tweet.integer :user_id
    end
  end
end
