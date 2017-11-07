class CreateTweets < ActiveRecord::Migration
  def up
    create_table :tweets do |t|
      t.string :content
    end
  end

  def down
  end
end
