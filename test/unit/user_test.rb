require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_name_cannot_be_blank
    user = users(:sunny)
    user.name = "   "
    assert !user.valid?
  end

  def test_name_unique
    user = User.new :name => "Sunny"
    assert !user.valid?, "user may not have the same name as another"

    user = User.new :name => "sunNY"
    assert !user.valid?, "user may not have the same name as another, even lowercased"
  end

  def test_bills
    assert_equal 3, users(:sunny).bills.size
  end
end
