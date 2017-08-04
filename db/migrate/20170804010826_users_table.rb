class UsersTable < ActiveRecord::Migration
  def up
    drop_table :users
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamp
    end
  end

  def down
    drop_table :users
  end
end
