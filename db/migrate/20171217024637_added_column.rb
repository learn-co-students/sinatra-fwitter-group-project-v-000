class AddedColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :user_id , :interger
  end
end
