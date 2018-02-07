class CreateTweets < ActiveRecord::Migration
  def up
    create_table :tweets do |t|
      t.string :content
      t.integer :user_ids
    end
  end

  def down
    drop_table :tweets
  end
end
