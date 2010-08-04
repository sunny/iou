class Debt < ActiveRecord::Base
  belongs_to :bill
  belongs_to :person_to, :class_name => 'Person'
  belongs_to :person_from, :class_name => 'Person'

  validates_numericality_of :amount, :greater_than => 0
  validates_presence_of :bill_id, 
                        :person_to_id,
                        :person_from_id
end
