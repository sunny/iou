class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :name, :null => false
      t.string :monetary_code
    end
    add_index :currencies, :monetary_code, :unique => true
  end

  def self.down
    drop_table :currencies
  end
end
