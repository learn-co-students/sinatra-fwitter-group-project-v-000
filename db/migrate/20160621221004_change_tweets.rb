class ChangeTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :user_id, :string
    add_column :tweets, :user_id, :integer
  end
end
