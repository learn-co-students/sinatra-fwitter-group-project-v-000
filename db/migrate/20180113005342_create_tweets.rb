class CreateTweets < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :content
      t.belongs_to :user
    end
  end
end
