require 'test_helper'

class FeeTransactionsControllerTest < ActionController::TestCase
  setup do
    @fee_transaction = fee_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fee_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fee_transaction" do
    assert_difference('FeeTransaction.count') do
      post :create, fee_transaction: { apartment_id: @fee_transaction.apartment_id, end_date: @fee_transaction.end_date, fee_id: @fee_transaction.fee_id, start_date: @fee_transaction.start_date, transaction_type: @fee_transaction.transaction_type, value: @fee_transaction.value }
    end

    assert_redirected_to fee_transaction_path(assigns(:fee_transaction))
  end

  test "should show fee_transaction" do
    get :show, id: @fee_transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fee_transaction
    assert_response :success
  end

  test "should update fee_transaction" do
    patch :update, id: @fee_transaction, fee_transaction: { apartment_id: @fee_transaction.apartment_id, end_date: @fee_transaction.end_date, fee_id: @fee_transaction.fee_id, start_date: @fee_transaction.start_date, transaction_type: @fee_transaction.transaction_type, value: @fee_transaction.value }
    assert_redirected_to fee_transaction_path(assigns(:fee_transaction))
  end

  test "should destroy fee_transaction" do
    assert_difference('FeeTransaction.count', -1) do
      delete :destroy, id: @fee_transaction
    end

    assert_redirected_to fee_transactions_path
  end
end
