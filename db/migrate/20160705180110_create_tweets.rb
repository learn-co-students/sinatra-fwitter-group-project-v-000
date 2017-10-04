class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user, index: true #needed this to create a tweet with user_id
      t.string :content
    end
  end
end
