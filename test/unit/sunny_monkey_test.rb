require 'test_helper'

class SunnyMonkeyTest < ActiveSupport::TestCase
  HASH = { :bacon => 42, :tasty => 52 }

  def test_array_to_h
    result = [[:bacon,42], [:tasty,52]].to_h
    assert_equal HASH, result
  end

  def test_array_to_h_with_block
    result = [[30, :bacon], [40, :tasty]].to_h { |k, v| [v, k+12] }
    assert_equal HASH, result
  end

  def test_hash_to_h
    assert_equal HASH, HASH.to_h
  end

  def test_hash_to_h_with_block
    result = ({ 30 => :bacon, 40 => :tasty }).to_h { |k, v| [v, k+12] }
    assert_equal HASH, result
  end
end

