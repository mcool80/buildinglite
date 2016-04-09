require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @admin = users(:two)
  end
  # test "the truth" do
  #   assert true
  # end

  test "user is not admin" do
    assert_not @user.admin?
  end
  test "user is admin" do
    assert @admin.admin?
  end
end
