class Bill < ActiveRecord::Base
  belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user_id'
  belongs_to :to_user,   :class_name => 'User', :foreign_key => 'to_user_id'
  
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
end
