class RenamePasswordDigest < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :password_digets, :password_digest
    end
  end
end
