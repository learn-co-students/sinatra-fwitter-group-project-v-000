class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.references :user, foreign_key: true
    end
  end

  def down
    drop_table :tweets
  end
end
