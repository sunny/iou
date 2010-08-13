class Bill < ActiveRecord::Base
  has_many :debts, :dependent => :destroy
  has_many :people_from, :through => :debts, :source => :person_from, :uniq => true
  has_many :people_to,   :through => :debts, :source => :person_to,   :uniq => true
  belongs_to :creator, :class_name => 'User'

  default_scope order(:date)

  validates_numericality_of :amount, :greater_than => 0
  validates_presence_of :description, :date

  before_validation :ensure_debts_sum_up_to_same_amount


  def people
    (people_from + people_to).uniq
  end

  def debt
    debts.first
  end

  def debt=(d)
    debts = [d]
  end

  def shared?
    bill_type == "Shared"
  end

  private

  def ensure_debts_sum_up_to_same_amount
    if amount != debts.to_a.sum { |d| d.amount }
      errors.add(:amount, "must be equal to the debts amount")
      false
    end
  end
end
