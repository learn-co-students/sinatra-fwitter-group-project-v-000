class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      # t.string :password # has_secure_password doesn't use this line
      t.string :password_digest
    end
  end
end
