class AddBillType < ActiveRecord::Migration
  def self.up
    change_table :bills do |t|
      t.string :bill_type, :default => "Bill", :null => false
    end
  end

  def self.down
    remove_column :bills, :bill_type
  end
end
