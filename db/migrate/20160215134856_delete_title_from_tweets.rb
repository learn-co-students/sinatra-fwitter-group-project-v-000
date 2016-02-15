class DeleteTitleFromTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :title
  end
end
