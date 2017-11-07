class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
    end

    def down
    end
  end
end
