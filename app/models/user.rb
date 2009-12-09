class User < ActiveRecord::Base
  has_many :participations, :include => [:bill, :user], :dependent => :destroy
  has_many :bills, :through => :participations, :uniq => true, :dependent => :destroy
  
  validates_presence_of :name
  named_scope :friends, :conditions => "users.id != 1"

  def you?
    self.id == 1
  end

  def User.you
    User.find(1)
  end
end
