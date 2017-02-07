class AddUniqueToTweets < ActiveRecord::Migration[5.0]
  def change
    add_index :tweets, :title, unique: true
  end
end
