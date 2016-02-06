require 'test_helper'

class FeePageControllerTest < ActionController::TestCase
  setup do
    @fee = fees(:one)
  end
  test "should get index" do
    get :index, id: @fee
    assert_response :success
  end

end
