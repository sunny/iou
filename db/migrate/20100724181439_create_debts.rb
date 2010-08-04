class CreateDebts < ActiveRecord::Migration
  def self.up
    create_table :debts do |t|
      t.float :amount
      t.integer :bill_id
      t.integer :person_from_id
      t.integer :person_to_id

      t.timestamps
    end
  end

  def self.down
    drop_table :debts
  end
end
