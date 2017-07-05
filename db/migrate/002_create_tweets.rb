class CreateTweets < ActiveRecord::Migration
  create_table :tweets do |t|
    t.string :content
    t.integer :user_id
  end
end
