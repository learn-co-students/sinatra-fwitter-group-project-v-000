class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string  :content, null: false
      t.integer :user_id, null: false
    end
  end
end
