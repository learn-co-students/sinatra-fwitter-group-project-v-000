class CreatePasswordDigest < ActiveRecord::Migrations

    remove_column :users, :password_digest
    add_column :users, :password_digest, :string


end
