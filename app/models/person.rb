class Person < ActiveRecord::Base
  has_many :debts_from, :class_name => 'Debt', :foreign_key => 'person_from_id'
  has_many :debts_to, :class_name => 'Debt', :foreign_key => 'person_to_id'

  validates :name, :presence => true
  validates :type, :presence => true, :inclusion => { :in => ['Friend', 'User'] }

  def debts
    Debt.includes(:bill).where('person_from_id = ? OR person_to_id = ?', id, id)
  end

  def in_bills
    Bill.includes(:debts).where('debts.person_from_id = ? OR debts.person_to_id = ?', id, id)
  end

  def owes(person)
    from = debts_from.where(:person_to_id   => person).sum('amount')
    to   = debts_to.  where(:person_from_id => person).sum('amount')
    to - from
  end

end
