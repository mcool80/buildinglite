require 'test_helper'

class AssignmentUpdatesControllerTest < ActionController::TestCase
  setup do
    sign_in @login_admin
    @assignment_update = assignment_updates(:one)
  end
  def create_assignment
      post :create, assignment_update: { assignment_id: @assignment_update.assignment_id, update_text: @assignment_update.update_text }
  end
  test "admin should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignment_updates)
  end

  test "admin should get new" do
    get :new
    assert_response :success
  end

  test "admin should create assignment_update" do
    assert_difference('AssignmentUpdate.count') do
      #post :create, assignment_update: { assignment_id: @assignment_update.assignment_id, update_text: @assignment_update.update_text }
      create_assignment
    end

    assert_redirected_to assignment_update_path(assigns(:assignment_update))
  end

  test "user should not create assignment_update" do
    sign_in @login_user
    assert_no_difference('AssignmentUpdate.count') do
      create_assignment
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "other admin should not create assignment_update" do
    sign_in @login_other_admin
    assert_no_difference('AssignmentUpdate.count') do
      create_assignment
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should show assignment_update" do
    get :show, id: @assignment_update
    assert_response :success
  end

  test "user should not show assignment_update" do
    sign_in @login_user
    get :show, id: @assignment_update
    assert_response :redirect
  end

  test "other admin should not show assignment_update" do
    sign_in @login_other_admin
    get :show, id: @assignment_update
    assert_response :redirect
  end

  test "admin should get edit" do
    get :edit, id: @assignment_update
    assert_response :success
  end

  test "user should not get edit" do
    sign_in @login_user
    get :edit, id: @assignment_update
    assert_response :redirect
  end

  test "other admin should not get edit" do
    sign_in @login_other_admin
    get :edit, id: @assignment_update
    assert_response :redirect
  end

  test "admin should update assignment_update" do
    patch :update, id: @assignment_update, assignment_update: { assignment_id: @assignment_update.assignment_id, update_text: @assignment_update.update_text }
    assert_redirected_to assignment_update_path(assigns(:assignment_update))
  end

  test "user should not update assignment_update" do
    sign_in @login_user
    patch :update, id: @assignment_update, assignment_update: { assignment_id: @assignment_update.assignment_id, update_text: @assignment_update.update_text }
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "other admin should not update assignment_update" do
    sign_in @login_other_admin
    patch :update, id: @assignment_update, assignment_update: { assignment_id: @assignment_update.assignment_id, update_text: @assignment_update.update_text }
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should destroy assignment_update" do
    assert_difference('AssignmentUpdate.count', -1) do
      delete :destroy, id: @assignment_update
    end

    assert_redirected_to assignment_updates_path
  end

  test "user should destroy assignment_update" do
    sign_in @login_user
    assert_no_difference('AssignmentUpdate.count') do
      delete :destroy, id: @assignment_update
    end

    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "other admin should destroy assignment_update" do
    sign_in @login_other_admin
    assert_no_difference('AssignmentUpdate.count') do
      delete :destroy, id: @assignment_update
    end

    assert_redirected_to request.headers["Referer"] || root_path
  end
end
