class CreateTweets < ActiveRecord::Migration[5.2]
  def up
    create_table :tweets do |t|
      t.string :tweet
    end
  end

  def down
    drop_table :tweets
  end

end
