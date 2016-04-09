require 'test_helper'

class FeeTransactionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:two)
    @fee_transaction = fee_transactions(:one)
    @fee_transaction_oap = fee_transactions(:four)
    @fee_transaction_payment = fee_transactions(:three)
  end

  test "user should get own fee_transactions" do
    sign_in @user 
    get :index
    assert_response :success
    fee_transactions  = assigns(:fee_transactions)
    fee_transactions.each do |ft|
      assert ft.start_date >= @user.apartment.moved && ft.apartment == @user.apartment, "Got FeeTransaction before move"
    end
  end

  test "user should get new" do
    get :new
    assert_response :success
  end

  test "user should create fee_transaction" do
    assert_difference('FeeTransaction.count') do
      post :create, fee_transaction: { apartment_id: @fee_transaction.apartment_id, end_date: @fee_transaction.end_date, fee_id: @fee_transaction.fee_id, start_date: @fee_transaction.start_date, transaction_type: @fee_transaction.transaction_type, value: @fee_transaction.value }
    end

    assert_redirected_to fee_transaction_path(assigns(:fee_transaction))
  end

  test "user should not create fee_transaction other than input" do
    assert_no_difference('FeeTransaction.count') do 
       post :create, fee_transaction: { apartment_id: @fee_transaction_payment.apartment_id, end_date: @fee_transaction_payment.end_date, fee_id: @fee_transaction_payment.fee_id, start_date: @fee_transaction_payment.start_date, transaction_type: @fee_transaction_payment.transaction_type, value: @fee_transaction_payment.value }
    end
    assert_response :redirect
  end

  test "user should not create fee_transaction in other apartment" do
    assert_no_difference('FeeTransaction.count') do 
       post :create, fee_transaction: { apartment_id: @fee_transaction_oap.apartment_id, end_date: @fee_transaction_oap.end_date, fee_id: @fee_transaction_oap.fee_id, start_date: @fee_transaction_oap.start_date, transaction_type: @fee_transaction_oap.transaction_type, value: @fee_transaction_oap.value }
    end
    assert_response :redirect
  end

  test "admin should create fee_transaction in other apartment" do
    sign_in users(:two)
    assert_difference('FeeTransaction.count') do 
       post :create, fee_transaction: { apartment_id: @fee_transaction_oap.apartment_id, end_date: @fee_transaction_oap.end_date, fee_id: @fee_transaction_oap.fee_id, start_date: @fee_transaction_oap.start_date, transaction_type: @fee_transaction_oap.transaction_type, value: @fee_transaction_oap.value }
    end
    assert_redirected_to fee_transaction_path(assigns(:fee_transaction))
  end

  test "user should show fee_transaction" do
    get :show, id: @fee_transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fee_transaction
    assert_response :success
  end

  test "user should not update fee_transaction" do
    assert_no_difference('FeeTransaction.count') do 
      patch :update, id: @fee_transaction, fee_transaction: { apartment_id: @fee_transaction.apartment_id, end_date: @fee_transaction.end_date, fee_id: @fee_transaction.fee_id, start_date: @fee_transaction.start_date, transaction_type: @fee_transaction.transaction_type, value: @fee_transaction.value }
    end
    assert_response :redirect
  end

  test "admin should update fee_transaction in other apartment" do
    sign_in users(:two)
    patch :update, id: @fee_transaction_oap, fee_transaction: { apartment_id: @fee_transaction_oap.apartment_id, end_date: @fee_transaction_oap.end_date, fee_id: @fee_transaction_oap.fee_id, start_date: @fee_transaction_oap.start_date, transaction_type: @fee_transaction_oap.transaction_type, value: @fee_transaction_oap.value }
    assert_redirected_to fee_transaction_path(assigns(:fee_transaction))
    sign_out users(:two)
  end

  test "user should destroy fee_transaction" do
    assert_difference('FeeTransaction.count', -1) do
      delete :destroy, id: @fee_transaction
    end
    assert_redirected_to fee_transactions_path
  end

  test "user should not destroy fee_transaction other than input" do
    assert_no_difference('FeeTransaction.count') do
      delete :destroy, id: @fee_transaction_payment
    end
    assert_response :redirect
  end

  test "admin should destroy fee_transaction in other apartment" do
    sign_in users(:two)
    assert_difference('FeeTransaction.count', -1) do
      delete :destroy, id: @fee_transaction_oap
    end
    assert_redirected_to fee_transactions_path
  end
end
