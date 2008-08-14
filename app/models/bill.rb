class Bill < ActiveRecord::Base
  belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user_id'
  belongs_to :to_user,   :class_name => 'User', :foreign_key => 'to_user_id'

  validates_presence_of  :kind
  validates_inclusion_of :kind, :in => 0..4, :allow_nil => true
  validates_numericality_of :amount, :greater_than => 0
  validate :ensure_user_from_and_to_is_different

  PAST_VERBS = %w[. owed lent gave got]

  def text
    "#{from_user.name} #{past_verb} #{to_user.name}"
  end

  def past_verb
    PAST_VERBS[kind]
  end

  private

  def ensure_user_from_and_to_is_different
    errors.add_to_base "From and to should be different" if from_user_id == to_user_id
  end
end
