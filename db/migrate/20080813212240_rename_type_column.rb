class RenameTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :bills, :type, :kind
  end

  def self.down
    rename_column :bills, :kind, :type
  end
end
