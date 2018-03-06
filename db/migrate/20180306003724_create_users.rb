class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
<<<<<<< HEAD
      t.string :password_digest
=======
      t.string :password
>>>>>>> 096a1e1040493406f2ddce67cb7fe4788a973d8c
    end
  end
end
