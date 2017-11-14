class AddUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :text
  end
end
