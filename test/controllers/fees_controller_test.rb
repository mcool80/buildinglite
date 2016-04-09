require 'test_helper'

class FeesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:two)
    @fee = fees(:one)
  end

  test "admin should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fees)
  end

  test "admin should get new" do
    get :new
    assert_response :success
  end

  test "admin should create fee" do
    assert_difference('Fee.count') do
      post :create, fee: { community_id: @fee.community_id, currency: @fee.currency, name: @fee.name, payment_interval: @fee.payment_interval, unit: @fee.unit }
    end

    assert_redirected_to fee_path(assigns(:fee))
  end

  test "user should not create fee" do
    sign_in users(:one)
    assert_no_difference('Fee.count') do
      post :create, fee: { community_id: @fee.community_id, currency: @fee.currency, name: @fee.name, payment_interval: @fee.payment_interval, unit: @fee.unit }
    end
    assert_response :redirect
  end


  test "admin should show fee" do
    get :show, id: @fee
    assert_response :success
  end

  test "admin should get edit" do
    get :edit, id: @fee
    assert_response :success
  end

  test "admin should update fee" do
    patch :update, id: @fee, fee: { community_id: @fee.community_id, currency: @fee.currency, name: @fee.name, payment_interval: @fee.payment_interval, unit: @fee.unit }
    assert_redirected_to fee_path(assigns(:fee))
  end

  test "user should not update fee" do
    sign_in users(:one)
    patch :update, id: @fee, fee: { community_id: @fee.community_id, currency: @fee.currency, name: @fee.name, payment_interval: @fee.payment_interval, unit: @fee.unit }
    assert_response :redirect
  end

  test "admin should destroy fee" do
    assert_difference('Fee.count', -1) do
      delete :destroy, id: @fee
    end

    assert_redirected_to fees_path
  end

  test "user should not destroy fee" do
    sign_in users(:one)
    assert_no_difference('Fee.count') do
      delete :destroy, id: @fee
    end
    assert_response :redirect
  end
end
