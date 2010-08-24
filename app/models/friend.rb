class Friend < Person
  belongs_to :creator, :class_name => 'User'
  validates_uniqueness_of :name, :scope => :creator_id
  validates :email, :nil => true
  validates :encrypted_password, :nil => true
  validates :password_salt, :nil => true
  validates :creator_id, :presence => true
end
