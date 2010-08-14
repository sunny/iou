class Friend < Person
  belongs_to :creator, :class_name => 'User'
  validates :email, :nil => true
  validates :encrypted_password, :nil => true
  validates :password_salt, :nil => true
  validates :creator_id, :nil => true
end
