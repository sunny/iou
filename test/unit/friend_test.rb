require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  should belong_to(:creator)
  should validate_presence_of("creator_id")
  should_not allow_value("email@example.org").for(:email)
  should_not allow_value("a").for(:encrypted_password)
  should_not allow_value("a").for(:password_salt)

  context "A friend" do
    setup do
      @friend = Factory(:friend)
    end

    should "be valid" do
      assert @friend.valid?
    end

    should "not have a brother with the same name" do
      brother = Factory.build(:friend, :name => @friend.name + ' ', :creator_id => @friend.creator_id)
      assert !brother.valid?, "should be invalid"
      assert brother.errors[:name], "should have an error on :name"
    end

    should "allow others to have the same name" do
      stranger = Factory.build(:friend, :name => @friend.name)
      assert stranger.valid?
    end
  end
end
