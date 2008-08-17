require 'test_helper'

class BillTest < ActiveSupport::TestCase
  def test_from_different_from_to
    bill = bills(:sunny_pays)
    bill.from_user_id = 1
    bill.to_user_id   = 1
    assert !bill.valid?, "From and to cannot not be the same"
  end

  def test_action
    bill = bills(:sunny_pays)
    assert_equal "Sunny payed Julie", bill.action
  end

  def test_title_for_bill_with_a_description
    bill = bills(:sunny_pays)
    assert_equal bill.description, bill.title
  end

  def test_title_for_bill_without_a_description
    bill = bills(:julie_pays)
    assert_equal bill.action, bill.title
  end
    

  def test_find_all_by_user
    sunny = users(:sunny)
    assert_equal 4, Bill.find_all_by_user(sunny.id).size
  end

  def test_debt_and_loans_for_user
    sunny = users(:sunny)
    julie = users(:julie)

    sunny_debts = Bill.debts_for_user(sunny)
    julie_debts = Bill.debts_for_user(julie)

    assert_equal -1.0, sunny_debts[julie.id]
    assert_equal  1.0, julie_debts[sunny.id]
  end
end
