require 'test_helper'

class CommunitiesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:two)
    @community = communities(:one)
  end

  test "admin should not get index" do
    get :index
    assert_response :redirect
  end

  test "admin should not get new" do
    get :new
    assert_response :redirect
  end

  test "admin should not create community" do
    assert_no_difference('Community.count') do
      post :create, community: { description: @community.description, name: @community.name }
    end
    assert_response :redirect
#    assert_redirected_to community_path(assigns(:community))
  end

  test "admin should show own community" do
    get :show, id: @community
    assert_response :success
  end

  test "admin should get edit own community" do
    get :edit, id: @community
    assert_response :success
  end

  test "admin should update own community" do
    patch :update, id: @community, community: { description: @community.description, name: @community.name }
    assert_redirected_to community_path(assigns(:community))
  end

  test "admin should not destroy community" do
    assert_no_difference('Community.count') do
      delete :destroy, id: @community
    end
    
    assert_response :redirect
#    assert_redirected_to communities_path
  end
end
