class CreatePasswordDigest < ActiveRecord::Migration[5.2]

    remove_column :users, :password_digest
    add_column :users, :password_digest, :string


end
