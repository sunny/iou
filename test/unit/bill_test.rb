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
  should validate_presence_of(:bill_type)
  should allow_value("Bill").for(:bill_type)
  should allow_value("Payment").for(:bill_type)
  should allow_value("Shared").for(:bill_type)
  should_not allow_value("Cheese").for(:bill_type)

  context "A Bill" do
    setup do
      @bill = Factory(:bill)
      @bill.debt = Factory(:debt, :amount => @bill.amount, :bill => @bill)
      @bill.save!
    end

    should "be valid" do
      assert @bill.valid?
    end

    should "have people" do
      assert_equal @bill.people.sort_by(&:id), [@bill.debt.person_to, @bill.debt.person_from].sort_by(&:id)
    end

    should "have a debt" do
      assert @bill.debt == @bill.debts.first
    end

    should "have only one debt" do
      @bill.debts = []
      @bill.debts << Factory(:debt, :amount => @bill.amount/2, :bill => @bill)
      @bill.debts << Factory(:debt, :amount => @bill.amount/2, :bill => @bill)
      assert !@bill.valid?, "Should not be .valid?"
      assert @bill.errors[:debts], "Should have errors on :debts"
    end

    should "ensure total amount is the same as the debts" do
      @bill.debt.amount = 100000
      @bill.debt.save
      assert !@bill.valid?, "Should not be .valid?"
      assert @bill.errors[:debts], "Should have errors on :debts"
    end

  end

  context "A shared Bill" do
    setup do
      @bill = Factory(:shared_bill)
      @bill.debts << Factory(:debt, :amount => @bill.amount/2, :bill => @bill)
      @bill.debts << Factory(:debt, :amount => @bill.amount/2, :bill => @bill)
      @bill.save!
    end

    should "be valid" do
      assert @bill.valid?
    end

    should "have more than one debt" do
        @bill.debt = Factory(:debt, :amount => @bill.amount, :bill => @bill)
        assert !@bill.valid?, "Should not be .valid?"
        assert @bill.errors[:debts], "Should have errors on :debts"
    end

    should "ensure total amount is the same as the debts" do
      @bill.debts.last.amount = 100000
      @bill.debts.last.save
      assert !@bill.valid?, "Should not be .valid?"
      assert @bill.errors[:debts], "Should have errors on :debts"
    end
  end
end

