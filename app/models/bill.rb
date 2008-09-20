class Bill < ActiveRecord::Base
  belongs_to :currency

  has_many :participations, :include => [:currency, :user]
  has_many :payer_participations, :class_name => 'Participation', :conditions => 'participations.payer = 1'
  has_many :payee_participations, :class_name => 'Participation', :conditions => 'participations.payer = 0'

  has_many :users, :through => :participations, :uniq => true
  has_many :payers, :through => :participations, :source => :user, :conditions => 'participations.payer = 1'
  has_many :payees, :through => :participations, :source => :user, :conditions => 'participations.payer = 0'

  validates_inclusion_of :loan, :in => [true, false]
  validates_presence_of :made_at
  validates_presence_of :amount
  validates_numericality_of :amount, :greater_than => 0, :allow_nil => true

  # Is this a shared bill? (Not just two participants)
  def shared?
    self.payer_participations.size > 1 or self.payee_participations.size > 1
  end

  # Returns the positive or negative total that everybody owes to the given user
  def balance_for_user(user, cur = Currency::EURO)
    user_participations = Participation.find_all_by_bill_id_and_user_id_and_currency_id(id, user.id, cur, :order => 'payer')
    owes, paid = user_participations
    (paid ? paid.amount : 0) - (owes ? owes.amount : 0)
  end
end
