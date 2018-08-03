class AddTitleColumnToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :title, :string

  end
end
