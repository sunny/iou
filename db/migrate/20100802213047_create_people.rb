class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.string :type


      # Devise columns

      # These columnd set by hand by hand because cannot set
      # null to thefaults with "t.database_authenticatable"
      t.string :email
      t.string :encrypted_password, :limit => 128
      t.string :password_salt
      
      t.rememberable
      # t.trackable
      # t.confirmable
      # t.recoverable
      # t.token_authenticatable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both

      t.integer :creator_id
      t.timestamps
    end

    # Indexes
    change_table :people do |t|
      t.index :name

      # Devise indexes
      t.index :email
      # t.index :reset_password_token, :unique => true
      # t.index :confirmation_token,   :unique => true
      # t.index :unlock_token,         :unique => true
    end
  end

  def self.down
    drop_table :people
  end
end
