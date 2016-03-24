class CreateTables < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :email
    end

    create_table :tweets do |t|
      t.string :content
      t.integer :owners_id
    end
  end
  
  def down
    drop_table :users
    drop_table :tweets
  end
  
end
