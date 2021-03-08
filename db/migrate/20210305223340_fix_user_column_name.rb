class FixUserColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :usernmae, :username
  end
end
