class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |c|
      c.string :content
      c.integer :user_id
    end
  end
end
