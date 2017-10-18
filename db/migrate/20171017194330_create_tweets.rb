class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :content
      t.integer :user_id
    end

    add_index :tweets, :user_id
    add_foreign_key :tweets, :users
  end
end
