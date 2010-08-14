class Bill < ActiveRecord::Base
  has_many :debts, :dependent => :destroy
  has_many :people_from, :through => :debts, :source => :person_from, :uniq => true
  has_many :people_to,   :through => :debts, :source => :person_to,   :uniq => true
  belongs_to :creator, :class_name => 'User'

  validates :amount, :numericality => { :greater_than => 0 }
  validates :description, :presence => true
  validates :date, :presence => true
  validates :bill_type, :presence => true, :inclusion => { :in => %w(Bill Payment Shared) }

  validate :debts_must_sum_up_to_the_same_amount, :if => :"errors.empty?"

  default_scope order(:date)


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

  def debts_must_sum_up_to_the_same_amount
    if amount != debts.to_a.sum { |d| d.amount }
      errors.add(:amount, "must be equal to the debts amount")
    end
  end
end
