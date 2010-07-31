class User < ActiveRecord::Base
  has_many :debts_from, :class_name => 'Debt', :foreign_key => 'user_from'
  has_many :debts_to, :class_name => 'Debt', :foreign_key => 'user_to'
  validates_presence_of :name

  def debts
    Debt.includes(:bill)
        .where('user_from_id = ? OR user_to_id = ?', id, id)
        .order('bills.date')
  end

  def bills
    Bill.includes(:debts)
        .where('debts.user_from_id = ? OR debts.user_to_id = ?', id, id)
        .order('date')
  end

end
