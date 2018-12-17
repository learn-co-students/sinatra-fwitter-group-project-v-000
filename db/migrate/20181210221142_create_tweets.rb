class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |i|
      i.string :content
      i.integer :user_id

    end
  end
end
