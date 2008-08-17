class BillAddPaymentBoolean < ActiveRecord::Migration
  def self.up
    change_table :bills do |t|
      t.boolean :payment, :boolean, :null => false, :default => 0
      t.remove :kind
    end
  end

  def self.down
    change_table :bills do |t|
      t.remove :payment
      t.integer :kind, :size => 1
    end
  end
end
