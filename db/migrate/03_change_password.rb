class ChangePassword < ActiveRecord::Migration
  rename_column :users, :password, :password_digest
end
