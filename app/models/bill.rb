class Bill < ActiveRecord::Base
  belongs_to :currency
  has_many :participations, :include => [:currency, :user]
  has_many :payer_participations, :class_name => "Participation", :conditions => 'participations.payer = 1'
  has_many :payee_participations, :class_name => "Participation", :conditions => 'participations.payer = 0'
  has_many :users, :through => :participations, :uniq => true

  validates_inclusion_of :loan, :in => [true, false]
  validates_presence_of :made_at
  validates_presence_of :amount
  validates_numericality_of :amount, :greater_than => 0, :allow_nil => true

  def shared?
    self.payer_participations.size > 1 or self.payee_participations.size > 1
  end
end
