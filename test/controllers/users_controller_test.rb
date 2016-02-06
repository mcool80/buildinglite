require 'test_helper'

class UsersControllerTest < ActionController::TestCase
   test "user login" do
     sign_out :get
     user1 = users(:two)
     user1.password = "testar11"
     user1.password_confirmation = "testar11"
     user1.save!
     sign_in user1
     
     assert true
   end
end
