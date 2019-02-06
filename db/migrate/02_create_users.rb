class CreateUsers < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :username
      t.string :password
      t.string :email
    end
  end
end
