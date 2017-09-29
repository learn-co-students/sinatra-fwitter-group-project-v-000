class RenameUserIdColumn < ActiveRecord::Migration
  def change
    remove_column :tweets, :owners_id
    add_column :tweets, :user_id, :integer
  end
end
