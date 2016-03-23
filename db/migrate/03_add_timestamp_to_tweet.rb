class AddTimestampToTweet < ActiveRecord::Migration
  def change
    change_table :tweets do |t|
      t.timestamps
    end
  end
end
