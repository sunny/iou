require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  should have_many(:debts_from)
  should have_many(:debts_to)

  should validate_presence_of(:name)
  should_not allow_value("Cheese").for(:type)
  should_not allow_value("Person").for(:type)

  context "A Person" do
    setup do
      # A friend is the simplest form of Person available
      @person = Factory(:friend)

      # Give it a debt
      @bill = Factory(:bill, :amount => 42)
      @bill.debt = Factory(:debt, :person_to => @person, :bill => @bill)
      @bill.save!
    end

    should "find its debts" do
      assert_equal @person.debts, [@bill.debt]
    end

    should "find its bills" do
      assert_equal @person.in_bills, [@bill]
    end

    should "calculate what it owes to another person" do
      @person2 = @bill.debt.person_from
      assert_equal 42, @person.owes(@person2)
      assert_equal -42, @person2.owes(@person)
    end

    should "keep his name trimmed" do
      @person.name = "	Trimmy "
      @person.save!
      assert_equal "Trimmy", @person.name
    end

    context "when destroyed" do
      should "destroy the bills that person appears in" do
        bills = @person.in_bills.map { |b| b.id }
        @person.destroy
        assert Bill.find_all_by_id(bills).empty?, "should not find old bills"
      end
    end

  end
end

