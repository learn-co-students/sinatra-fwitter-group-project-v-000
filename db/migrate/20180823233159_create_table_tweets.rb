class CreateTableTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet
      t.integer :user_id
    end
  end
end
