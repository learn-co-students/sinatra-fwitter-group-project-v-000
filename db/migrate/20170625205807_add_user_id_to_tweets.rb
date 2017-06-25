class AddUserIdToTweets < ActiveRecord::Migration
  def change
  	add_column :tweet, :user_id, :integre
  end
end
