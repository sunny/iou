class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table(:people) do |t|
      t.string :name
      t.string :type

      # Devise
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      # t.trackable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.integer :creator_id
      t.timestamps
    end

    add_index :people, :email
    add_index :people, :reset_password_token, :unique => true
    # add_index :people, :confirmation_token,   :unique => true
    # add_index :people, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :people
  end
end
