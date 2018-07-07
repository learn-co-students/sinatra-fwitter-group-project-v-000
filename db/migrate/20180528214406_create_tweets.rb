class CreateTweets < ActiveRecord::Migration
  def up
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
      t.timestamps null: false
    end
  end

  def down
    drop_table :tweets
  end

end
