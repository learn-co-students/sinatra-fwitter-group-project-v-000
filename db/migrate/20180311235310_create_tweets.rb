class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id #foreign key
      t.timestamps null: false 
    end
  end
end
