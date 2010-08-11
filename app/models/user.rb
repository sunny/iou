class User < Person
  has_many :friends, :foreign_key => 'creator_id'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Accessible (or protected) attributes for devise
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  def can_edit_person?(person)
    self.admin? or self == person or self.friends.include?(person)
  end
end
