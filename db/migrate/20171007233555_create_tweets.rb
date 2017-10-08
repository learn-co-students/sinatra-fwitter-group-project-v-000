class CreateTweets < ActiveRecord::Migration
  def change
    create_table do |t|
      t.string :name
      t.integer :user_id
    end
  end
end
