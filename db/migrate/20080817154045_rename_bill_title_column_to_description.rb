class RenameBillTitleColumnToDescription < ActiveRecord::Migration
  def self.up
    rename_column :bills, :title, :description
  end

  def self.down
    rename_column :bills, :description, :title
  end
end
