class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :post
    end
  end
end
