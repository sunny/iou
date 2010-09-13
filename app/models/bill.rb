class Bill < ActiveRecord::Base
  has_many :debts, :dependent => :destroy, :autosave => true
  has_many :people_from, :through => :debts, :source => :person_from, :uniq => true
  has_many :people_to,   :through => :debts, :source => :person_to,   :uniq => true
  belongs_to :creator, :class_name => 'User'

  validates :amount, :numericality => { :greater_than => 0 }
  validates :description, :presence => true
  validates :date, :presence => true
  validates :bill_type, :presence => true, :inclusion => { :in => %w(Bill Payment Shared) }
  validates :creator, :presence => true

  validate :ensure_correct_number_of_debts, :unless => :"debts.empty?"
  validate :debts_must_sum_up_to_the_same_amount, :unless => :"debts.empty?"

  default_scope order('bills.date DESC, bills.id DESC')

  def people
    (people_from + people_to).uniq
  end

  def debt
    debts.first
  end

  def debt=(d)
    self.debts = [d]
  end

  def shared?
    bill_type == "Shared"
  end

  # We can give it an amount of "4 200,50" and it will set it right
  def amount=(value)
    value = value.gsub(' ', '').sub(',', '.').to_f if value.is_a?(String)
    super(value)
  end

  private

  def ensure_correct_number_of_debts
    if shared?
      errors.add(:debts, "count must be at least 2 if the bill is shared") if debts.length == 1
    else
      errors.add(:debts, "count must be only 1 if the bill isn't shared") if debts.length != 1
    end
  end

  def debts_must_sum_up_to_the_same_amount
    if amount != debts.to_a.sum { |d| d.amount }
      errors.add(:amount, "must be equal to the debts amount")
    end
  end
end
