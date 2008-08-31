class Currency < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :money_code, :allow_nil => true
end
