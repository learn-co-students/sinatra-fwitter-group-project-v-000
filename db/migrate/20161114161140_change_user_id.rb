class ChangeUserId < ActiveRecord::Migration
  def change
    change_column :tweets, :user_id, :integer
  end
end
