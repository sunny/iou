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
      @bill.debts << Factory(:debt, :amount => @bill.amount, :bill => @bill)
      @bill.save!
    end

    should "be valid" do
      assert @bill.valid?
    end

    should "have only one debt" do
      @bill.debts = []
      @bill.debts << Factory(:debt, :amount => @bill.amount/2, :bill => @bill)
      @bill.debts << Factory(:debt, :amount => @bill.amount/2, :bill => @bill)
      assert !@bill.valid?
      assert @bill.errors[:debts]
    end

    should "return a debt" do
      assert @bill.debt == @bill.debts.first
    end
  end

  context "A shared Bill" do
    setup do
      @bill = Factory.create(:shared_bill)
      @bill.debts << Factory(:debt, :amount => @bill.amount/2, :bill => @bill)
      @bill.debts << Factory(:debt, :amount => @bill.amount/2, :bill => @bill)
      @bill.save!
    end

    should "be valid" do
      assert @bill.valid?
     end

     should "have more than one debt" do
        @bill.debts = [Factory(:debt, :amount => @bill.amount, :bill => @bill)]
        assert !@bill.valid?
        assert @bill.errors[:debts]
     end
   end
end

