class CreateTweets < ActiveRecord::Migration
def change

          create_table :tweets do |table|
                                   table.text :content
                                   table.integer :user_id
                              end


end
end
