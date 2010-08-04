class Bill < ActiveRecord::Base
  has_many :debts
  has_many :people_from, :through => :debts, :source => :person_from, :uniq => true
  has_many :people_to,   :through => :debts, :source => :person_to,   :uniq => true
  belongs_to :creator, :class_name => 'User'

  default_scope order(:date)

  validates_numericality_of :amount, :greater_than => 0
  validates_presence_of :description, :date

  def people
    (people_from + people_to).uniq
  end

  def missing_amount
    amount - debts.sum(:amount)
  end
end
