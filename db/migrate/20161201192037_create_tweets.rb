class CreateTweets < ActiveRecord::Migration
  def change
  	create_table :tweet do |t|
  		t.string :content
  		t.integer :user_id
  	end
  end
end
