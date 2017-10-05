class CreateTweets < ActiveRecord::Migration
  def change
  	create_table :tweets do |t|
  		t.string :content
  		t.belongs_to :user, index: true
  		t.timestamps
  	end
  end
end
