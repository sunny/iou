class AddAdminBoolean < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.boolean :admin, :default => false, :null => false
    end
    User.first.try{ |u| u.admin = true; u.save! }
  end

  def self.down
    remove_column :people, :admin
  end
end
