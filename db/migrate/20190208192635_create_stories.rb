class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :genre
      t.string :summary
      t.text :notes
    end
  end
end
