class CreateTweets < ActiveRecord::Migration[4.2]
  def change
    create_table :tweets do |t|
      t.string :content
      t.belongs_to :user
    end
  end

end
