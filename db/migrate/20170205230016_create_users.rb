class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, unique: true, null: false
      t.string :email, unique: true, null: false
      t.index :email, unique: true
      t.index :username, unique: true
      t.string :password_digest, null: false
    end
  end
end
