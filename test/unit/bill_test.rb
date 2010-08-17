require 'test_helper'

class BillTest < ActiveSupport::TestCase
  should have_many(:debts)
  should have_many(:people_from)
  should have_many(:people_to)
  should belong_to(:creator)

  should_not allow_value("-1").for(:amount)
  should validate_presence_of(:description)
  should validate_presence_of(:date)
  should validate_presence_of(:creator)
  should validate_presence_of(:debts)
  should validate_presence_of(:bill_type)
  should allow_value("Bill").for(:bill_type)
  should allow_value("Payment").for(:bill_type)
  should allow_value("Shared").for(:bill_type)
  should_not allow_value("Cheese").for(:bill_type)

  context "A Bill" do
    setup do
      @bill = Factory.create(:bill)
    end

    should "be valid" do
      assert @bill.valid?
    end
  end
end
