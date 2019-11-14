class CreateTweets < ActiveRecord::Migration[4.2]
  def up
    create_table :tweets do |t|
      t.text :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :tweets
  end
end
