class Debt < ActiveRecord::Base
  belongs_to :bill
  belongs_to :person_to, :class_name => 'Person'
  belongs_to :person_from, :class_name => 'Person'

  validates_numericality_of :amount, :greater_than => 0
  validates :bill, :presence => true
  validates :person_from, :presence => true
  validates :person_to, :presence => true
  
  before_save :validates_to_and_from_are_different
  
  
  def validates_to_and_from_are_different
    unless person_to != person_from
      errors[:person_to] << 'must be different from the person from'
      return false
    end
  end
  
end
