class Tweet < ActiveRecord::Base
  belongs_to :user
end

# class CreateTweetsTable < ActiveRecord::Migration[4.2.5]
#   def change
#     create_table :tweets do |t|
#       t.text :content
#       t.integer :user_id
#
#       t.timestamps null: false
#     end
#   end
# end
#
