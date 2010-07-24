class Bill < ActiveRecord::Base
  has_many :debts
  has_many :users, :through => :debts
  
  def title
    @description
  end
end
