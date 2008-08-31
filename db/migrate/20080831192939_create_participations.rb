class CreateParticipations < ActiveRecord::Migration
  def self.up
    create_table :participations do |t|
      t.references :bill, :null => false
      t.references :user, :null => false
      t.references :currency, :null => false
      t.float :amount, :null => false
      t.boolean :payer, :null => false
      t.boolean :fixed
      t.timestamps
    end
    add_index :participations, :bill_id
    add_index :participations, :user_id
    add_index :participations, :payer
  end

  def self.down
    drop_table :participations
  end
end
