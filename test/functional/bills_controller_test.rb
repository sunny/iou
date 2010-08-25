require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = Factory(:user)
    @friend = Factory(:friend, :creator => @user)
    @bill = Factory(:bill, :creator => @user, :amount => 42)
    @bill.debt = Factory(:debt, :bill => @bill,
      :amount => 42,
      :person_from => @user,
      :person_to => @friend)
    @bill.save!
    sign_in @user
  end

  should "get overview" do
    get :overview
    assert_response :success
    assert_equal [], assigns(:you_owe)
    assert_equal [[@friend, 42]], assigns(:owes_you)
  end

  should "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bills)
  end

  should "get new" do
    get :new
    assert_response :success
  end

  should "create bill" do
    assert_difference('Bill.count') do
      post :create, "bill"=>{"bill_type"=>"Bill", "amount"=>"20", "description"=>"Test", "date(3i)"=>"18", "date(2i)"=>"8", "date(1i)"=>"2010"}, "friend_name"=>"Max", "you_payed"=>"true"
    end

    assert_redirected_to bill_path(assigns(:bill))
    assert_equal assigns(:bill).creator_id, @user.id, "should have the current user as the creator"
  end

  should "show bill" do
    get :show, :id => @bill.to_param
    assert_response :success
  end

  should " get edit" do
    get :edit, :id => @bill.to_param
    assert_response :success
  end

  should "update bill amount" do
    put :update, :id => @bill.to_param, "bill"=>{"bill_type"=>"Bill", "amount"=>"30", "description"=>"Test", "date(3i)"=>"18", "date(2i)"=>"8", "date(1i)"=>"2010"}, "friend_name"=>"Max", "you_payed"=>"true"
    assert_redirected_to bill_path(@bill)
  end

  should "destroy bill" do
    assert_difference('Bill.count', -1) do
      delete :destroy, :id => @bill.to_param
    end

    assert_redirected_to bills_path
  end

  context "With another user's bill" do
    setup do
      @bill.creator = Factory(:user)
      @bill.save!
    end

    should "not show" do
      get :show, :id => @bill.to_param
      assert_response 404
    end

    should "not edit" do
      get :show, :id => @bill.to_param
      assert_response 404
    end

    should "not update" do
      put :update, :id => @bill.to_param, :bill => {:amount => 42, :bill_type => "Payment", :description => "Testing"}, :friend_name => "Joe", :you_payed => "true"
      assert_response 404
    end

    should "not destroy" do
      delete :destroy, :id => @bill.to_param
      assert_response 404
    end
  end
end
