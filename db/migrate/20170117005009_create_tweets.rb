class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
      t.datetime
    end  
  end
end
