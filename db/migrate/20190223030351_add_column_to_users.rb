class AddColumnToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :password_digest, :password
  end
end
