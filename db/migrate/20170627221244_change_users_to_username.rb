class ChangeUsersToUsername < ActiveRecord::Migration
  def change
    rename_column :users, :users, :username
  end
end
