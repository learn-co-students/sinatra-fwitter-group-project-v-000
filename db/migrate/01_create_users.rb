class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :username
      u.text :email
      u.string :password_digest
    end
    
  end
  
end