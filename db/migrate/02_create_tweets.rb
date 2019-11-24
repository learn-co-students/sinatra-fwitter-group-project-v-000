class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets |tweet|
     tweet.text :content
     tweet.integer :user_id 

    tweet.timestamps null: false
    end
  end
end
