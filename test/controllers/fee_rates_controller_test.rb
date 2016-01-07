require 'test_helper'

class FeeRatesControllerTest < ActionController::TestCase
  setup do
    @fee_rate = fee_rates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fee_rates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fee_rate" do
    assert_difference('FeeRate.count') do
      post :create, fee_rate: { end_date: @fee_rate.end_date, fee_id: @fee_rate.fee_id, rate_apartment: @fee_rate.rate_apartment, rate_cost: @fee_rate.rate_cost, start_date: @fee_rate.start_date }
    end

    assert_redirected_to fee_rate_path(assigns(:fee_rate))
  end

  test "should show fee_rate" do
    get :show, id: @fee_rate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fee_rate
    assert_response :success
  end

  test "should update fee_rate" do
    patch :update, id: @fee_rate, fee_rate: { end_date: @fee_rate.end_date, fee_id: @fee_rate.fee_id, rate_apartment: @fee_rate.rate_apartment, rate_cost: @fee_rate.rate_cost, start_date: @fee_rate.start_date }
    assert_redirected_to fee_rate_path(assigns(:fee_rate))
  end

  test "should destroy fee_rate" do
    assert_difference('FeeRate.count', -1) do
      delete :destroy, id: @fee_rate
    end

    assert_redirected_to fee_rates_path
  end
end
