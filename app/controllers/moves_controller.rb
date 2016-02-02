class MovesController < ApplicationController
  before_action :authenticate_user!, :security_check


  def index
    @apartment = Apartment.find(params[:id])
  end

  def add_user
    @user = User.new(user_params)
    if ! @user.valid?
      @apartment = Apartment.find(params[:apartment_id])
      alert = 'User was NOT successfully created.' 
      render 'index'
    else
      if @user.save!
        redirect_to "/moves/"+@user.apartment_id.to_s, notice: 'User was successfully created.' 
      end
    end
  end

  def add_input
  end
 
  private
    def security_check
      if ! current_user.is_administrator
        redirect_to "/"
      end 
    end
   
    def user_params
      params.permit(:email, :apartment_id, :password, :password_confirmation)
    end
end
