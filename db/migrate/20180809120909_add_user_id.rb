class AddUserId < ActiveRecord::Migration
  def change
    add_column :tweets, :user_id, :integer  
    remove_column :users, :user_id
  end
end
