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
  end
end
