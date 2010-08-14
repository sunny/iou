require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  should have_many(:debts_from)
  should have_many(:debts_to)

  should validate_presence_of(:name)
  should_not allow_value("Cheese").for(:type)
  should_not allow_value("Person").for(:type)
end
