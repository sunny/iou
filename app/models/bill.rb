class Bill < ActiveRecord::Base
  belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user_id'
  belongs_to :to_user,   :class_name => 'User', :foreign_key => 'to_user_id'

  validates_inclusion_of :payment, :in => [true, false]
  validates_presence_of :transaction_at
  validates_presence_of :amount
  validates_numericality_of :amount, :greater_than => 0, :allow_nil => true
  validate :ensure_user_from_and_to_is_different

  def title
    self.description.blank? ? self.action : self.description
  end

  def action
    "%s %s %s" % [self.from_user.name, self.past_verb, self.to_user.name]
  end

  def past_verb
    self.payment? ? "payed" : "owes"
  end

  def verb
    self.payment? ? "pay" : "owe"
  end

  # turns the amount into a debt or a loan depending on the given user
  def signed_amount(for_user_id = nil)
    signed = self.amount
    signed *= -1 if self.from_user_id == for_user_id
    signed *= -1 if !self.payment?
    signed
  end

  # Find all bills from or to a single user.
  def self.find_all_by_user(u)
    uid = u.kind_of?(User) ? u.id : u
    self.find :all, :conditions => ['from_user_id = ? or to_user_id = ?', uid, uid]
  end

  # Find all the debts for a user.
  # returns a hash {user_id => debt, user_id => debt, ...}
  def self.debts_for_user(u)
    debts = {}
    uid = u.kind_of?(User) ? u.id : u
    bills = find_all_by_user(uid)
    for bill in bills
      with_uid, to = (bill.to_user_id == uid) ? bill.from_user_id : bill.to_user_id
      debts[with_uid] ||= 0
      debts[with_uid] += bill.signed_amount(uid)
    end
    debts
  end

  private

  def ensure_user_from_and_to_is_different
    errors.add_to_base "One can't really #{self.verb} oneself, can one?" if from_user_id == to_user_id
  end
end
