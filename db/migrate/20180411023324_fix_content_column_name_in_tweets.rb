class FixContentColumnNameInTweets < ActiveRecord::Migration
  def change
  	rename_column :tweets, :context, :content 
  end
end
