class RemovePasswordFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :password_hash
  end

  def self.down
    add_column :users, :password_hash, :string
  end
end
