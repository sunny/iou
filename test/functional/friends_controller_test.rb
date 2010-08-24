require 'test_helper'

class FriendsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = Factory(:user)
    @friend = Factory(:friend, :creator => @user)
    sign_in @user
  end

  should "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friends)
  end

  should "get new" do
    get :new
    assert_response :success
  end

  should "create friend" do
    assert_difference('Friend.count') do
      post :create, :friend => { :name => "Solidus" }
    end

    assert_redirected_to friends_path
  end

  should "show friend" do
    get :show, :id => @friend.to_param
    assert_response :success
  end

  should "get edit" do
    get :edit, :id => @friend.to_param
    assert_response :success
  end

  should "update friend" do
    put :update, :id => @friend.to_param, :friend => @friend.attributes
    assert_redirected_to friends_path
  end

  should "destroy friend" do
    assert_difference('Friend.count', -1) do
      delete :destroy, :id => @friend.to_param
    end

    assert_redirected_to friends_path
  end

  context "With another user's friend" do
    setup do
      @friend.creator = Factory(:user)
      @friend.save!
    end

    should "not show" do
      get :show, :id => @friend.to_param
      assert_response 404
    end

    should "not edit" do
      get :show, :id => @friend.to_param
      assert_response 404
    end

    should "not update" do
      put :update, :id => @friend.to_param, :friend => @friend.attributes
      assert_response 404
    end

    should "not destroy" do
      delete :destroy, :id => @friend.to_param
      assert_response 404
    end
  end
end

