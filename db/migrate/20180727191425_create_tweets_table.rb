
class CreateTweetsTable < ActiveRecord::Migration
  
  def change
    create_table :tweets do |column|
      column.string :content
    end
  end
  
end
