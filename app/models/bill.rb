class Bill < ActiveRecord::Base
  belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user_id'
  belongs_to :to_user,   :class_name => 'User', :foreign_key => 'to_user_id'

  validates_numericality_of :amount, :greater_than => 0
  validates_inclusion_of :kind, :in => 0..4
  validate :ensure_user_from_and_to_is_different

  def text
    "#{from_user.name} #{verb} #{to_user.name}"
  end
  
  def verb
    case kind
      when 1: "owed"
      when 2: "lent"
      when 3: "gave"
      when 4: "got"
      else ""
    end
  end

  private

  def ensure_user_from_and_to_is_different
    errors.add_to_base "From and to should be different" if from_user_id == to_user_id
  end
end
