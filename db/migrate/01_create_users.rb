class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string :username
    t.string :email
    t.string :password
    t.integer :tweet_id
    end
  end
end
