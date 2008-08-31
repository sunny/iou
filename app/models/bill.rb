class Bill < ActiveRecord::Base
  belongs_to :currency
  has_many :participations
  has_many :users, :through => :participations

  validates_inclusion_of :loan, :in => [true, false]
  validates_presence_of :made_at
  validates_presence_of :amount
  validates_numericality_of :amount, :greater_than => 0, :allow_nil => true


end
