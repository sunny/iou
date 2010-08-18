class AddUserRecoverable < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.recoverable # devise column reset_password_token
    end
  end

  def self.down
    remove_column :people, :reset_password_token
  end
end
