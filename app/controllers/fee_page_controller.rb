class FeePageController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @fee = Fee.find(params[:id])
      current_apartment = Apartment.find(current_user.apartment_id)
      if params[:apartment_id] and current_user.is_administrator
         current_apartment = Apartment.where(:id => params[:apartment_id], :community_id => current_user.community.id).first
      end
      if @fee.community_id == current_apartment.community_id 
        ap = Apartment.find(current_user.apartment_id)
        if ap.moved == nil
          move_date = Date.parse('1900-01-01')
        else
          move_date = ap.moved
        end
        @ft = FeeTransaction.where(fee_id: @fee.id, apartment_id: current_apartment.id).where('start_date >= ?', move_date)
	@current_payment = FeeTransaction.where(fee_id: @fee.id, apartment_id: current_apartment.id, transaction_type: "payment").order(:start_date).first
        @apartment = current_apartment
      else
        # redirect to error page
      end
    end
  end
  def add
    ft = FeeTransaction.new(apartment_id: current_user.apartment_id, fee_id: params[:fee_id], value: params[:value], start_date: params[:start_date], transaction_type: "input")
    ft.save
    redirect_to "/fee_page/" + params[:fee_id]
    
  end

  def administrate
    if user_signed_in?
      @fee = Fee.find(params[:id])
    end
  end
  
  def check_fee
    if user_signed_in?
      community = current_user.community
      fee_id = params[:id]
      @fee = Fee.find(fee_id)
      @apartments = Apartment.where(:community_id => community.id)
    else
      # TODO: Redirect?    
    end
  end
  
  def save_result
    fee_id = params[:fee_id]
    transaction_type = params[:transaction_type]
    result_date = params[:result_date]
    apartment_ids = params[:apartment_id]
    results = params[:result]
    i = 0
    while i < apartment_ids.count do
      ft = FeeTransaction.new
      ft.fee_id = fee_id
      ft.start_date = result_date
      ft.apartment_id = apartment_ids[i]
      ft.transaction_type = transaction_type
      ft.value = results[i]
      ft.save
      i += 1
    end
  end
end
