class User < ActiveRecord::Base
  has_many :debts_from, :class_name => 'Debt', :foreign_key => 'user_from'
  has_many :debts_to, :class_name => 'Debt', :foreign_key => 'user_to'
  
  def debts
    Debt.find_all(:conditions => "user_from_id = #{id} OR user_to_id = #{id}")
  end
  
  def title
    @name
  end
end
