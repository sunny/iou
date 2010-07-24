class Bill < ActiveRecord::Base
  has_many :debts
  has_many :users_from, :through => :debts, :source => :user_from
  has_many :users_to, :through => :debts, :source => :user_to

  validates_numericality_of :amount, :greater_than => 0
  validates_presence_of :description, :date

  def title
    @description
  end
  
  def has_enough_debts?
    debts.sum(:amount) == amount
  end
  
  def missing_debts_amount
    amount - debts.sum(:amount)
  end
end
