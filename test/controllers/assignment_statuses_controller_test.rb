require 'test_helper'

class AssignmentStatusesControllerTest < ActionController::TestCase
  setup do
    sign_in(users(:two))
    @assignment_status = assignment_statuses(:one)
    @assignment_status_delete = assignment_statuses(:five)
  end

  test "admin should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignment_statuses)
  end

  test "user should not get index" do
    sign_in(users(:one))
    get :index
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should get new" do
    get :new
    assert_response :success
  end

  test "user should not get new" do
    sign_in(users(:one))
    get :new
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should create assignment_status" do
    assert_difference('AssignmentStatus.count') do
      post :create, assignment_status: { status: @assignment_status.status, close_state: @assignment_status.close_state, community_id: @assignment_status.community_id }
    end
    assert_redirected_to assignment_status_path(assigns(:assignment_status))
  end

  test "other admin should not create assignment_status" do
    sign_in(users(:five))
    assert_no_difference('AssignmentStatus.count') do
      post :create, assignment_status: { status: @assignment_status.status, close_state: @assignment_status.close_state, community_id: @assignment_status.community_id }
    end
    assert_response :redirect
  end

  test "user should not create assignment_status" do
    sign_in(users(:one))
    assert_no_difference('AssignmentStatus.count') do
      post :create, assignment_status: { status: @assignment_status.status, close_state: @assignment_status.close_state, community_id: @assignment_status.community_id }
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should show assignment_status" do
    get :show, id: @assignment_status
    assert_response :success
  end

  test "admin should get edit" do
    get :edit, id: @assignment_status
    assert_response :success
  end

  test "admin should update assignment_status" do
    patch :update, id: @assignment_status, assignment_status: { status: @assignment_status.status, close_state: @assignment_status.close_state, community_id: @assignment_status.community_id }
    assert_redirected_to assignment_status_path(assigns(:assignment_status))
  end

  test "user should not update assignment_status" do
    sign_in(users(:one))
    patch :update, id: @assignment_status, assignment_status: { status: @assignment_status.status, close_state: @assignment_status.close_state, community_id: @assignment_status.community_id }
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "other admin should not update assignment_status" do
    sign_in(users(:five))
    patch :update, id: @assignment_status, assignment_status: { status: @assignment_status.status, close_state: @assignment_status.close_state, community_id: @assignment_status.community_id }
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should destroy assignment_status" do
    assert_difference('AssignmentStatus.count', -1) do
      delete :destroy, id: @assignment_status_delete
    end
    assert_redirected_to assignment_statuses_path
  end

  test "user should not destroy assignment_status" do
    sign_in(users(:one))
    assert_no_difference('AssignmentStatus.count') do
      delete :destroy, id: @assignment_status_delete
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "other admin should not destroy assignment_status" do
    sign_in(users(:five))
    assert_no_difference('AssignmentStatus.count') do
      delete :destroy, id: @assignment_status_delete
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should not create two close assignment_statues" do
    assert_no_difference('AssignmentStatus.count') do
      post :create, assignment_status: { status: @assignment_status.status, close_state: true, community_id: @assignment_status.community_id }
    end
    assert_response :success
  end

  test "admin should not update two close assignment_statues" do
    patch :update, id: @assignment_status, assignment_status: { status: @assignment_status.status, close_state: true, community_id: @assignment_status.community_id }
    assert_equal 1, AssignmentStatus.where(close_state: true, community_id: @assignment_status.community_id).count
  end
end
