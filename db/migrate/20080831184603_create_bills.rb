class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.string :description
      t.float :amount
      t.date :made_on
      t.boolean :loan, :null => false
      t.references :currency, :null => false
      t.timestamps
    end
    add_index :bills, :loan
    add_index :bills, :made_on
  end

  def self.down
    drop_table :bills
  end
end
