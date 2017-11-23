class AddUserid < ActiveRecord::Migration

  add_column :tweets, :user_id, :integer

end
