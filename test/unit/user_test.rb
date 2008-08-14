require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_name_cannot_be_blank
    user = users(:sunny)
    user.name = "   "
    assert !user.valid?
  end
end
