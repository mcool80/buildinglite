require 'test_helper'

class ApartmentsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:two)
    @apartment = apartments(:one)
    @apartment2 = apartments(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apartments)
  end

  test "admin should get new" do
    get :new
    assert_response :success
  end

  test "admin should create apartment" do
    assert_difference('Apartment.count') do
      post :create, apartment: { address: @apartment2.address, apartment_no: @apartment2.apartment_no, community_id: @apartment2.community_id, moved: @apartment2.moved }
    end

    assert_redirected_to apartment_path(assigns(:apartment))
  end

  test "user should not create apartment" do
    sign_in users(:one)
    assert_no_difference('Apartment.count') do
      post :create, apartment: { address: @apartment.address, apartment_no: @apartment.apartment_no, community_id: @apartment.community_id, moved: @apartment.moved }
    end
    assert_response :redirect
  end

  test "admin should show apartment" do
    get :show, id: @apartment
    assert_response :success
  end

  test "user should show info apartment" do
    sign_in users(:one)
    get :showinfo, id: @apartment
    assert_response :success
  end

  test "admin should get edit" do
    get :edit, id: @apartment
    assert_response :success
  end

  test "admin should update apartment" do
    patch :update, id: @apartment, apartment: { address: @apartment.address, apartment_no: @apartment.apartment_no, community_id: @apartment.community_id }
    assert_redirected_to apartment_path(assigns(:apartment))
  end

  test "admin should destroy apartment" do
    assert_difference('Apartment.count', -1) do
      delete :destroy, id: @apartment
    end
    assert_redirected_to apartments_path
  end

  test "user should not destroy apartment" do
    sign_in users(:one)
    assert_no_difference('Apartment.count') do
      delete :destroy, id: @apartment
    end
    assert_response :redirect
  end
end
