class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.text     :description
      t.float    :amount
      t.datetime :date
      t.integer  :creator_id
      t.string   :bill_type, :default => "Bill", :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :bills
  end
end
