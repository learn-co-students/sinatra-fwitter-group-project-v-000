class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :title, unique: true, null: false
      t.text :content
      t.timestamps null: false
    end
  end
end
