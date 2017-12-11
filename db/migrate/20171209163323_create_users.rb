class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password # Note: this should be password_digest; fixed in later migration
    end
  end
end
