require 'test_helper'

class BillTest < ActiveSupport::TestCase
  def test_past_verb
    assert_equal bills(:owed).past_verb, 'owed'
    assert_equal bills(:lent).past_verb, 'lent'
  end

  def test_from_different_from_to
    bill = bills(:owed)
    bill.from_user_id = 1
    bill.to_user_id   = 1
    assert !bill.valid?, "From and to cannot not be the same"
  end
end
