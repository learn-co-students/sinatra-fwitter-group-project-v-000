class RemoveColumnFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :tweets
  end
end
