class Debt < ActiveRecord::Base
  belongs_to :bill
  belongs_to :user_to, :class_name => 'User'
  belongs_to :user_from, :class_name => 'User'
end
