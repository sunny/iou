require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = Factory(:user)
    @bill = Factory(:bill, :creator => @user)
    @bill.debt = Factory(:debt, :person_from => @user, :bill => @bill)
    @bill.save!
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill" do
    assert_difference('Bill.count') do
      post :create, "bill"=>{"bill_type"=>"Bill", "amount"=>"20", "description"=>"Test", "date(3i)"=>"18", "date(2i)"=>"8", "date(1i)"=>"2010"}, "friend_name"=>"Max", "you_payed"=>"true"
    end

    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should show bill" do
    get :show, :id => @bill.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bill.to_param
    assert_response :success
  end

  test "should update bill" do
    put :update, :id => @bill.to_param, :bill => {:amount => 42, :bill_type => "Payment", :description => "Testing"}, :friend_name => "Joe", :you_payed => "true"
    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should destroy bill" do
    assert_difference('Bill.count', -1) do
      delete :destroy, :id => @bill.to_param
    end

    assert_redirected_to bills_path
  end
end
