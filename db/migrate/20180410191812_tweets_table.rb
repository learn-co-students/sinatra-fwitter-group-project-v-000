class TweetsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id #bzc tweets belongs_to user with specific id
    end
  end
end
