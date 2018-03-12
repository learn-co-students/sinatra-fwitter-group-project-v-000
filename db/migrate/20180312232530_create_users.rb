class CreateUsers < ActiveRecord::Migration
  def change
    t.string :username
    t.string :email
    t.string :password
  end
end
