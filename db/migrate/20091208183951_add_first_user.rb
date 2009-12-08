class AddFirstUser < ActiveRecord::Migration
  def self.up
    User.create(:name => "You", :email => "you@example.org")
  end

  def self.down
    User.find_by_email('you@example.org').destroy
  end
end
