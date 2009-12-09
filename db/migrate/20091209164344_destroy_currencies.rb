class DestroyCurrencies < ActiveRecord::Migration
  def self.up
    drop_table :currencies
    remove_column :participations, :currency_id
    remove_column :bills,          :currency_id
  end

  def self.down
    create_table :currencies do |t|
      t.string :name, :null => false
      t.string :monetary_code
    end
    add_index :currencies, :monetary_code, :unique => true

    add_column :participations, :currency_id, :integer
    add_column :bills,          :currency_id, :integer
  end
end
