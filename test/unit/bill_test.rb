require 'test_helper'

class BillTest < ActiveSupport::TestCase
  def test_verb
    assert_equal bills(:one).verb, 'owed'
    assert_equal bills(:two).verb, 'lent'
  end
end
