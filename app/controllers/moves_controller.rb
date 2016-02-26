class MovesController < ApplicationController
  before_action :authenticate_user!, :security_check, :setup_wizard

  def update_fees
    @fees = Fee.where(:community_id => current_user.community.id)
    @fee_transaction = FeeTransaction.new
  end

  def select_apartment
    @apartments = current_user.community.apartments.order(:address)
    @apartment = Apartment.new
  end
  
  def change_users
    session[:moved] = params[:moved]
    session[:apartment_id] = params[:id]
  end

  def add_user
    @user = User.new(user_params)
    if ! @user.valid?
      flash[:alert] = t('User was NOT successfully created.')
    else
      if @user.save!
        flash[:notice] = t('User was successfully created.') 
      end
    end
    render 'change_users'
  end

  def remove_user
    @user = User.find(params[:user_id])
    @user.apartment_id = nil
    if @user.save!
      flash[:notice] = t('User was successfully removed.') 
    else
      flash[:notice] = t('User was NOT successfully removed.') 
    end
    render 'change_users'
  end

  def add_input
    @fees = Fee.where(:community_id => current_user.community.id)
    @fee_transaction = FeeTransaction.new(fee_transaction_params)
    if !@fee_transaction.save
       flash[:notice] = t("Input cannot be saved")
    else
       flash[:notice] = t("Input has been saved")
    end
    render 'update_fees'
  end

  def finish
    if session.has_key?(:moved) then
      @apartment.moved = session[:moved]
      @apartment.save
      flash[:notice] = t("Apartment has been updated with move")
    end
  end
 
  private
    def setup_wizard
      if params.has_key?(:id)
         @apartment = Apartment.find(params[:id])
      elsif session.has_key?(:apartment_id)
         @apartment = Apartment.find(session[:apartment_id])
      end
      if @apartment
        @users = User.where(:apartment_id => @apartment.id)
      end
    end

    def security_check
      if ! current_user.is_administrator
        redirect_to "/"
      end 
    end
   
    def user_params
      params.permit(:email, :apartment_id, :password, :password_confirmation)
    end

    def fee_transaction_params
      params.permit(:apartment_id, :date, :transaction_type, :value)
    end
end
