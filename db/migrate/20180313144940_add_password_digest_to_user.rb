class AddPasswordDigestToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :integer
  end
end
