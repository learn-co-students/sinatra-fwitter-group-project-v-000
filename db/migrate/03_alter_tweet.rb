class AlterTweet < ActiveRecord::Migration
  def change
    change_table :tweets do |t|
      t.integer :user_id
    end
  end
end