class User < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :bills, :finder_sql =>
      'SELECT * FROM bills ' +
      'WHERE from_user_id = #{id.to_i} OR to_user_id = #{id.to_i} ' +
      'ORDER BY transaction_at'

  def password=(p)
    self[:password_hash] = User.hash_password(p)
  end

  def password
    "********"
  end

  # Find all the user's debts with others as a hash of user_ids and amounts
  #   user.debts # => { 3 => 42.25, 4 => -2.5 }
  def debts
    Bill.debts_for_user(self)
  end

  def self.authenticate(username, password)
    self.find_by_name_and_password_hash(username, self.hash_password(password))
  end

  def self.hash_password(password)
    Digest::SHA1.hexdigest("-#{SALT}-#{password}-")
  end
end
