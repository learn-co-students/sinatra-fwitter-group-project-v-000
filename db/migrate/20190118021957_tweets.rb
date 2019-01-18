class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id

      t.timestamps null: false #testing this feature
    end
  end
end
