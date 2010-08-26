require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:bills)
  should have_many(:friends)

  should_not allow_value(1).for(:creator_id)
  should validate_presence_of(:password_salt)

  should validate_presence_of(:email)
  should_not allow_value("blah").for(:email)
  should allow_value("a@b.com").for(:email)

  should validate_presence_of(:encrypted_password)
  should_not allow_mass_assignment_of(:encrypted_password)

  context "A User" do
    setup do
      @user = Factory.create(:user)
    end

    should "be valid" do
      assert @user.valid?
    end

    should "have a unique email" do
      assert !Factory.build(:user, :email => @user.email.upcase).valid?
    end

    context "when destroyed" do
      should "destroy his friends" do
        friends = @user.friend_ids
        @user.destroy
        assert Friend.find_all_by_id(friends).empty?, "should not find old friends"
      end
      should "destroy his created bills" do
        bills = @user.bill_ids
        @user.destroy
        assert Bill.find_all_by_id(bills).empty?, "should not find old bills"
      end
    end
  end
end
