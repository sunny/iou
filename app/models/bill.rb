class Bill < ActiveRecord::Base
  has_many :debts
  has_many :users_from, :through => :debts, :source => :user_from, :uniq => true
  has_many :users_to,   :through => :debts, :source => :user_to,   :uniq => true

  default_scope order(:date)

  validates_numericality_of :amount, :greater_than => 0
  validates_presence_of :description, :date

  def users
    (users_from + users_to).uniq
  end
  
  def shared?
    debts.length > 1
  end

  def missing_amount
    amount - debts.sum(:amount)
  end
end
