require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can_edit_person?" do
    assert people(:dew).can_edit_person?(people(:dew)), "users can edit themselves"
    assert people(:dew).can_edit_person?(people(:dew_friend)), "users can edit friends"
    assert !people(:dew).can_edit_person?(people(:admin)), "users cannot edit others"
    assert people(:admin).can_edit_person?(people(:dew)), "admins can edit other users"
  end
end
