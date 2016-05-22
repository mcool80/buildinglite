require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
  setup do
    sign_in(users(:two))
    @assignment = assignments(:one)
    @assignment_other = assignments(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignment" do
    assert_difference('Assignment.count') do
      post :create, assignment: { comment: @assignment.comment, duedate: @assignment.duedate, no: @assignment.no, reference: @assignment.reference, assignment_status_id: @assignment.assignment_status_id, text: @assignment.text, user_id: @assignment.user_id, community_id: @assignment.community_id } 
    end
    assert_redirected_to assignment_path(assigns(:assignment))
  end

  test "other admin should not create assignment" do
    sign_in(users(:five))
    assert_no_difference('Assignment.count') do
      post :create, assignment: { comment: @assignment.comment, duedate: @assignment.duedate, no: @assignment.no, reference: @assignment.reference, assignment_status_id: @assignment.assignment_status_id, text: @assignment.text, user_id: @assignment.user_id, community_id: @assignment.community_id } 
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "user should not create assignment" do
    sign_in(users(:one))
    assert_no_difference('Assignment.count') do
      post :create, assignment: { comment: @assignment.comment, duedate: @assignment.duedate, no: @assignment.no, reference: @assignment.reference, assignment_status_id: @assignment.assignment_status_id, text: @assignment.text, user_id: @assignment.user_id, community_id: @assignment.community_id } 
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "should show assignment" do
    get :show, id: @assignment
    assert_response :success
  end

  test "admin should get edit" do
    get :edit, id: @assignment
    assert_response :success
  end

  test "user should not get edit" do
    sign_in(users(:one))
    get :edit, id: @assignment
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should update assignment" do
    patch :update, id: @assignment, assignment: { comment: @assignment.comment, duedate: @assignment.duedate, no: @assignment.no, reference: @assignment.reference, assignment_status_id: @assignment.assignment_status_id, text: @assignment.text, user_id: @assignment.user_id, community_id: @assignment.community_id }
    assert_redirected_to assignment_path(assigns(:assignment))
  end

  test "user should not update assignment" do
    sign_in(users(:one))
    patch :update, id: @assignment, assignment: { comment: @assignment.comment, duedate: @assignment.duedate, no: @assignment.no, reference: @assignment.reference, assignment_status_id: @assignment.assignment_status_id, text: @assignment.text, user_id: @assignment.user_id, community_id: @assignment.community_id }
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "admin should destroy empty assignment" do
    assert_difference('Assignment.count', -1) do
      delete :destroy, id: @assignment_other
    end
    assert_redirected_to assignments_path
  end

  test "other admin should destroy assignment" do
    sign_in(users(:five))
    assert_no_difference('Assignment.count') do
      delete :destroy, id: @assignment
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end

  test "user should not destroy assignment" do
    sign_in(users(:one))
    assert_no_difference('Assignment.count') do
      delete :destroy, id: @assignment
    end
    assert_redirected_to request.headers["Referer"] || root_path
  end
  
  test "number suggestion for new assignment" do
    get :new
    assert_response :success
    assert_equal assignments(:three).no + 1, assigns(:assignment).no
  end
 
  test "admin should close assignment" do
    get :close, id: @assignment
    changed_assignment = Assignment.find(@assignment.id)
    assert_not_nil changed_assignment.close_date
    assert changed_assignment.assignment_status.close_state
  end

  test "user should not close assignment" do
    sign_in(users(:one))
    get :close, id: @assignment
    assert_redirected_to request.headers["Referer"] || root_path
    changed_assignment = Assignment.find(@assignment.id)
    assert_nil changed_assignment.close_date
    assert_not changed_assignment.assignment_status.close_state
  end
  
  test "admin should see not closed assigments in index" do
    get :index
    assert_response :success
    assigns(:assignments).each do |assignment|
      assert_nil assignment.close_date
      assert_not assignment.assignment_status.close_state
    end
  end

  test "admin should see only closed assigments in closed_list" do
    get :closed_list
    assert_response :success
    assigns(:assignments).each do |assignment|
      assert_not_nil assignment.close_date
      assert assignment.assignment_status.close_state
    end
  end

  test "admin should see latest updates" do
    get :latest_updates
    assigns(:assignments).each do |assignment|
      assert_nil assignment.close_date
    end
    assert_response :success
  end

  test "user should not see latest updates" do
    sign_in @login_user
    get :latest_updates
    assert_response :redirect
  end

  test "other admin should not see latest updates" do
    sign_in @login_other_admin
    get :latest_updates
    assert_response :redirect
  end
end
