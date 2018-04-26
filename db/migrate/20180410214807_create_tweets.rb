class CreateTweets < ActiveRecord::Migration[5.2]
  def change
  	create_table :tweets do |t|
  		t.text :context 
  		t.integer :user_id 
  	end 
  end
end
