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

  def owes(user)
    from = debts_from.where('debts.user_to = ?', user).sum('amount')
    to = debts_to.where('debts.user_from = ?', user).sum('amount')
    from - to
  end

  def friends
    debts.map { |debt| debt.user }
      .uniq
      .reject { |user| user.id === id }
  end
  
  def friends_diff
    diff = {}
    friends.each {
      owes(friend)
    }
  end
end
