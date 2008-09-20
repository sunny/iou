require 'test_helper'

class BillTest < ActiveSupport::TestCase
  def test_users
    assert_equal 4, bills(:sushi_ba).users.size
  end

  def test_payer_payee_participations
    assert_equal 2, bills(:sushi_ba).payer_participations.size
    assert_equal 4, bills(:sushi_ba).payee_participations.size
  end

  def test_payers_payees
    assert_equal [users(:julie)], bills(:julie_paid_sunny).payers
    assert_equal [users(:sunny)], bills(:julie_paid_sunny).payees
    assert_equal 2, bills(:sushi_ba).payers.size
    assert_equal 4, bills(:sushi_ba).payees.size
  end

  def test_shared
    assert bills(:sushi_ba).shared?
    assert !bills(:julie_paid_sunny).shared?
  end

  def test_balance_for_user
    assert_equal 61.75 - 9.50, bills(:sushi_ba).balance_for_user(users(:sunny), euro)
  end

end
