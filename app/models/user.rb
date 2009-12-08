class User < ActiveRecord::Base
  has_many :participations, :include => [:bill, :user, :currency]
  has_many :bills, :through => :participations, :include => [:currency], :uniq => true
  has_many :currencies, :through => :participations, :uniq => true

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
end
