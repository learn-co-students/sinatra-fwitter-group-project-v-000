
class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
       t.string :content
       t.integer :user_id
    end
  end
end
