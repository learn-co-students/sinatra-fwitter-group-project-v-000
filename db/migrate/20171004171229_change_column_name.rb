class ChangeColumnName < ActiveRecord::Migration
  def change

   rename_column :tweets, :user, :user_id

  end
end
