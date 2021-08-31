class UpdateUsernameColumn < ActiveRecord::Migration[6.0]
  change_table :users do |t|
      t.rename :user_name, :username
  end
end
