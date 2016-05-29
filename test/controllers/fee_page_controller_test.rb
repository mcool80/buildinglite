require 'test_helper'

class FeePageControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user_admin = users(:two)
    @fee = fees(:one)
  end

  test "user can rech index" do
    sign_in @user
    get :index, id: @fee
    assert_response :success
    assert_not_nil assigns(:fee_transactions)
  end

  test "admin can reach index" do
    sign_in @user_admin
    get :index, id: @fee
    assert_response :success
    assert_not_nil assigns(:fee_transactions)
  end

  test "admin can reach check fee page" do
    sign_in @user_admin
    get :check_fee, id: @fee
    assert_response :success
  end

  test "admin can reach check fee report" do
    sign_in @user_admin
    get :fee_report, id: @fee
    assert_response :success
  end

  test "admin can create fee report" do
    sign_in @user_admin
    get :fee_report, id: @fee, start_date: '2011-05-09', transaction_type: 'payment'
    assert_response :success

    get :fee_report, id: @fee, start_date: '2011-05-09', transaction_type: 'payment', format: 'csv'
    assert_response :success

  end
  
  test "admin calculate fees" do
    sign_in @user_admin
    get :check_fee, id: @fee, start_date: '2011-05-09', end_date: '2011-01-01', fixed_rate: 100, variable_rate: 10
    assert_response :success

    assert false, "Implement check calculations"
  end

end

