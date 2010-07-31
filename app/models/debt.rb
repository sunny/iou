class Debt < ActiveRecord::Base
  belongs_to :bill
  belongs_to :user_to, :class_name => 'User'
  belongs_to :user_from, :class_name => 'User'

  default_scope includes(:bill).order('bills.date, bills.id')

  validates_presence_of :bill_id, :user_to_id, :user_from_id
  validates_numericality_of :amount, :greater_than => 0
end
