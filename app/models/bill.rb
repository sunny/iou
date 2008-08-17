class Bill < ActiveRecord::Base
  belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user_id'
  belongs_to :to_user,   :class_name => 'User', :foreign_key => 'to_user_id'

  validates_presence_of  :kind
  validates_inclusion_of :kind, :in => 0..4, :allow_nil => true
  validates_numericality_of :amount, :greater_than => 0
  validate :ensure_user_from_and_to_is_different

  #                 1    2    3    4
  PAST_VERBS = %w[. owed lent gave got]

  def past_phrase
    "%s %s %s %d €" % [self.from_user.name, self.past_verb, self.to_user.name, self.amount]
  end

  def past_verb
    PAST_VERBS[self.kind]
  end

  # turns the amount into a debt (or a loan if negative)
  def signed_amount(for_user_id = nil)
    signed = self.amount
    signed *= -1 if self.from_user_id == for_user_id
    signed *= -1 if self.kind == 1 or self.kind == 4
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
    errors.add_to_base "From and to should be different" if from_user_id == to_user_id
  end
end
