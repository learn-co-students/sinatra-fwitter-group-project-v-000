class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
    end
  end
end
