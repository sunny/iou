class User < Person
  has_many :bills, :foreign_key => 'creator_id'
  has_many :friends, :foreign_key => 'creator_id'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Accessible (or protected) attributes for devise
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  validates :email, :presence => true, :format => { :with => /^[^@]+@[^@]+\.[^@]+$/ }
  validates :encrypted_password, :presence => true
  validates :password_salt, :presence => true
  validates :creator_id, :nil => true
end
