class CreateTables < ActiveRecord::Migration
  def change

    create_table :users do |t|

      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :tweet_id

    end

    create_table :tweets do |t|
      t.string :content
    end
  end
end
