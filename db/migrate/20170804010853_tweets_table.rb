class TweetsTable < ActiveRecord::Migration
  def up
    drop_table :tweets
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id

      t.timestamp
    end
  end
  def down
   drop_table :tweets
  end

end
