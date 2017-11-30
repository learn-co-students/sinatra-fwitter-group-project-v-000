class ChangeUserPasswordToPasswordDigest < ActiveRecord::Migration
  def change
    change_column :users, :password, :password_digest
  end
end
