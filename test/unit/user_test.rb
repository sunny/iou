require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_bills
    assert_equal 3, users(:sunny).bills.size
  end
  def test_currencies
    assert_equal [currencies(:euro)], users(:sunny).currencies
  end
end
