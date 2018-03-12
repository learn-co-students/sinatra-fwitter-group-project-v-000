class CreateTweets < ActiveRecord::Migration
  def change
    t.string :content
    t.integer :user_id
  end
end
