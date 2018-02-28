class DeleteColumn < ActiveRecord::Migration[5.1]
  def down
    delete_column :users, :password
  end
end
