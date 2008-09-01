require 'test_helper'

class BillTest < ActiveSupport::TestCase
  def test_users
    assert_equal 3, bills(:sushi_ba).users.size
  end

  def test_payer_payee_participations
    assert_equal 2, bills(:sushi_ba).payer_participations.size
    assert_equal 3, bills(:sushi_ba).payee_participations.size
  end

  def test_payers_payees
    assert_equal [users(:julie)], bills(:julie_paid_sunny).payers
    assert_equal [users(:sunny)], bills(:julie_paid_sunny).payees
    assert_equal 2, bills(:sushi_ba).payers.size
    assert_equal 3, bills(:sushi_ba).payees.size
  end

  def test_shared
    assert bills(:sushi_ba).shared?
    assert !bills(:julie_paid_sunny).shared?
  end

  def test_total_owed_to
    assert_equal 71.75-10-9.50, bills(:sushi_ba).total_owed_to(users(:sunny))
  end

  def test_owed_to
    owed = { user(:julie) => 9.50-10, user(:}
    assert_equal owed, bills(:sushi_bas).owed_to(users(:sunny))
  end
end
