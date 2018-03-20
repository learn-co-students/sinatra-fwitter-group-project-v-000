class RemoveColumnString < ActiveRecord::Migration[5.1]
  def change
  	remove_column :tweets, :user_id, :string
  end
end
