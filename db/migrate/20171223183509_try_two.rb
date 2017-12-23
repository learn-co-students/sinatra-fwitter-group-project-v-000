class TryTwo < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :password_id, :password_digest
  end
end
