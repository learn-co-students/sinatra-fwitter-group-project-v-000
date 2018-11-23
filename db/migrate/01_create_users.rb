class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.text :email
      #should it be a string? #what is the difference between string and text
      #should be text because of @ sign?
      t.string :password_digest
    end
  end
end
