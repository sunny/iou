class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :bill

  named_scope :paying,        :conditions => { :payer => true }
  named_scope :participating, :conditions => { :payer => false }
  named_scope :with_amount,   :conditions => 'amount != 0'
  named_scope :by_user_name,  lambda { |name| { :conditions => ['users.name = ?', name], :include => :user } }

  validates_presence_of :user
  # validates_presence_of :bill
  validates_numericality_of :amount
  # validates_inclusion_of :payer, :in => [0, 1]

  before_validation :default_values

  def default_values
    self.user.save if (self.user and self.user.new_record?)
    self.amount ||= 0
    self.payer ||= 0
    self.fixed ||= 0
  end


end
