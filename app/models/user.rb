class User < ActiveRecord::Base
  has_many :participations, :include => [:bill, :user, :currency]
  has_many :bills, :through => :participations, :include => [:currency], :uniq => true
  has_many :currencies, :through => :participations, :uniq => true

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false

  def password=(p)
    self[:password_hash] = User.hash_password(p) unless p.blank?
  end

  def password
    ""
  end

  def self.authenticate(username, password)
    self.find_by_name_and_password_hash(username, self.hash_password(password))
  end

  def self.hash_password(password)
    Digest::SHA1.hexdigest("-#{SALT}-#{password}-")
  end
end
