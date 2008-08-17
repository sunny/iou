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

  # Returns a positive or negative amount number depending
  # if it is considered a debt or a loan to the given user.
  def signed_amount(user = nil)
    user_id = user.kind_of?(User) ? user.id : user
    signed = self.amount
    signed *= -1 if self.from_user_id == user_id
    signed *= -1 if !self.payment?
    signed
  end

  # Find all the debts for a user.
  # returns a hash {user_id => debt, user_id => debt, ...}
  def self.debts_for_user(user)
    debts = {}
    user = User.find(user) unless user.kind_of?(User)
    for bill in user.bills
      with_user = (bill.to_user_id == user.id) ? bill.from_user_id : bill.to_user_id
      debts[with_user] ||= 0
      debts[with_user] += bill.signed_amount(user)
    end
    debts.to_h { |id, amount| [User.find(id), amount] }
  end

  private

  def ensure_user_from_and_to_is_different
    errors.add_to_base "One can't really #{self.verb} oneself, can one?" if from_user_id == to_user_id
  end
end
