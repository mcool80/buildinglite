class FeePageController < ApplicationController
  before_action :authenticate_user!, :set_globals

  def index
    @fee = Fee.find(params[:id])
    authorize @fee
    if @fee.community_id == $current_apartment.community_id 
      ap = Apartment.find(current_user.apartment_id)
      move_date = ap.moved.nil? ? Date.parse('1900-01-01') : ap.moved
      @fee_transactions = FeeTransaction.where(fee_id: @fee.id, apartment_id: $current_apartment.id).where('start_date >= ?', move_date).order(:start_date).reverse
      @current_payment = FeeTransaction.where(fee_id: @fee.id, apartment_id: $current_apartment.id, transaction_type: "payment").order(:start_date).last
      @fee_transaction = FeeTransaction.new
    end
  end

  def administrate
    @fee = Fee.find(params[:id])
    authorize @fee
  end

  def add_fee_transaction
    @fee = Fee.find(params[:id])
    authorize @fee
    @fee_transaction = FeeTransaction.new
    if params[:apartment] then
      @apartment = Apartment.find(params[:apartment][:id])
    end
    @apartments = Apartment.where(:community_id => current_user.community.id).order(:address)
    if @apartment.nil? then
      @apartment = @apartments.first
    end
    @fee_transactions = FeeTransaction.where(:apartment_id => @apartment.id, :fee_id => @fee.id).order(:start_date).reverse
  end
  
  def check_fee
    fee_id = params[:id]
    @fee = Fee.find(fee_id)
    authorize @fee

    community = current_user.community
    @apartments = Apartment.where(:community_id => community.id)
  end
  
  def save_result
    fee = Fee.find(params[:fee_id])
    authorize fee
    transaction_type = params[:transaction_type]
    result_date = params[:result_date]
    apartment_ids = params[:apartment_id]
    results = params[:result]
    i = 0
    while i < apartment_ids.count do
      ft = FeeTransaction.new
      ft.fee_id = fee.id
      ft.start_date = result_date
      ft.apartment_id = apartment_ids[i]
      ft.transaction_type = transaction_type
      ft.value = results[i]
      if not ft.value.nil? then
        ft.save
      end
      i += 1
    end
    respond_to do |format|
      format.html { redirect_to :action => 'fee_report',  :id => fee, :start_date => result_date, :transaction_type => transaction_type, notice: t('saved_result') }
    end
  end
  def fee_report
    fee_id = params[:id]
    @fee = Fee.find(fee_id)
    authorize @fee

    community = current_user.community
    @apartments = Apartment.where(:community_id => community.id)
    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Disposition'] = "attachment; filename=\"export.csv\""
        response.headers['Content-Type'] ||= 'text/csv'
      end
    end
  end
private

  def fee_transaction_params
    params.require(:fee_transaction).permit(:start_date, :end_date, :transaction_type, :value, :fee_id, :apartment_id)
  end

end
