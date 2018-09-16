class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
<<<<<<< HEAD
      t.string :password_digest
=======
      t.string :password
>>>>>>> 5703a4a9a2581946db52475e1e9bdcf9c9f7859f
    end
  end
end
