require 'test_helper'

class UsersControllerTest < ActionController::TestCase

   def setup
     @user = users(:one)
     @user2 = users(:four)
     @apartment = apartments(:two)
     @admin = users(:two)
     @unconnected_user = users(:three)
   end

   test "user should update own user" do
     @controller = Users::RegistrationsController.new
     @request.env["devise.mapping"] = Devise.mappings[:user]
     sign_in @user
     patch :update, user: { apartment_id: @user.apartment_id, first_name: @user2.first_name, last_name: @user2.last_name, phone: @user2.phone, mobile: @user2.mobile, password: @user.password, password_confirmation: @user.password, current_password: 'password' }
     assert_equal @user2.first_name, User.find(@user.id).first_name
   end

   test "user should not update other user" do
     patch :update, id: @unconnected_user, user: { apartment_id: @user.apartment_id, first_name: @user.first_name, 
                                                   last_name: @user.last_name, phone: @user.phone, mobile: @user.mobile, 
                                                   password: @user.password, password_confirmation: 'password' }
     assert_not_equal @user.first_name, User.find(@unconnected_user.id).first_name
   end

   test "admin should connect unconnected user" do
     sign_in @admin
     patch :update, id: @unconnected_user, user: { apartment_id: @user.apartment_id }
     assert_equal @user.apartment_id, User.find(@unconnected_user.id).apartment_id
   end

   test "admin should update apartment for user in community" do
     sign_in @admin
     patch :update, id: @user, user: { apartment_id: @apartment.id }
     assert_equal @apartment.id, User.find(@user.id).apartment_id
   end

   test "admin should not connect other community user" do
     sign_in @admin
     post :connect, user: { email: @user2.email, apartment_id: @user.apartment_id }
     assert_not_equal @user.apartment_id, User.find(@user2.id).apartment_id
   end

   test "admin should disconnect own user" do
     sign_in @admin
     patch :update, id: @user, user: { apartment_id: nil }
     assert_not_equal @user.apartment_id, User.find(@user2.id).apartment_id
   end

   test "admin should create new user for apartment" do
     sign_in @admin
     assert_difference('User.count') do
       post :connect, user: { email: 'test@testar.av', apartment_id: @user.apartment_id, first_name: @user.first_name, last_name: @user.last_name, phone: @user.phone, mobile: @user.mobile, password: 'Password11', password_confirmation: 'Password11' }
     end
   end
end
