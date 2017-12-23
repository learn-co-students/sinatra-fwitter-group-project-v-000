class ChangeColumnTweets < ActiveRecord::Migration
  def change
    rename_column :tweets, :userid, :user_id
  end
end
