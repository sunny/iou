class Friend < Person
  belongs_to :creator, :class_name => 'User'
end
