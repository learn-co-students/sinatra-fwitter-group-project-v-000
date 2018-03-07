class CreateTweets < ActiveRecord::Migration
#Tweets should have content, belong to a user.
  def change
    create_table :tweets do |t|
    t.string :content
    t.integer :user_id
  end
  end
end
