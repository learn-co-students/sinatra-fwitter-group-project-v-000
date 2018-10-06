class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.text :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> 035be2bdac21e180ce5a046687ab27bdbfde090c
