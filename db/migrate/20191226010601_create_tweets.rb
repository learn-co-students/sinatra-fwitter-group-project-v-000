class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id #belongs to a user
    end
  end
end
