class AddContentToTweets < ActiveRecord::Migration
  def change
    rename_column :tweets, :text, :content
  end
end
