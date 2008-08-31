class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_hash
      t.timestamps
    end
    add_index :users, :email, :unique => true
    add_index :users, [:email, :password_hash]
  end

  def self.down
    drop_table :users
  end
end
