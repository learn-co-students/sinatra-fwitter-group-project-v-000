class CreateUsers < ActiveRecord::Migration[4.2]

  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      # t.float :cost, default: 0
    end
  end

end
