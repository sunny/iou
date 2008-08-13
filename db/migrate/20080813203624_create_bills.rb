class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.string :title
      t.float :amount
      t.integer :type, :size => 1 # loan, debt, give, get

      t.integer :from_user_id
      t.integer :to_user_id

      t.date :transaction_at
      t.timestamps
    end
  end

  def self.down
    drop_table :bills
  end
end
