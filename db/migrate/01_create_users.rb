class CreateUsersTable < ActiveRecord::Migration

def change
  create_table :users do |user|
    user.string :username
    user.text :email
    user.string :password_digest

    user.timestamps null: false
   end
  end
end 
