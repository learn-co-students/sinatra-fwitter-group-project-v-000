class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :content
      t.timestamp null:false
    end
  end
end
