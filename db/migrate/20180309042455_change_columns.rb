class ChangeColumns < ActiveRecord::Migration
  def change
  	rename_column :users, :name, :username
  	rename_column :users, :password_digest, :password
  end
end
