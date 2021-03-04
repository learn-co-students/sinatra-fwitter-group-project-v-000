class UsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
        t.string  :usernmae
        t.text    :email
        t.string   :password_digest
    end 
  end
end
