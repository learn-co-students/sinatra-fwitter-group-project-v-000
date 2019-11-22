class CreateUsers < ActiveRecord::Migration[4.2]
  def up
    create_table :users do |t|
      t.string :username
      t.text :email
      t.string :password_digest

      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
