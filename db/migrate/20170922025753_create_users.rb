class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
    end
  end

  def down
    drop_table :users
  end
end
