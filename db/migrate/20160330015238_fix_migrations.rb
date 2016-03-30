class FixMigrations < ActiveRecord::Migration
  def change
    drop_table :user_tweets

    add_column :tweets, :user_id, :integer
  end
end
