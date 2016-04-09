class FeeTransactionsController < ApplicationController
  before_action :authenticate_user!, :set_globals
  before_action :set_fee_transaction, only: [:show, :edit, :update, :destroy]

  # GET /fee_transactions
  # GET /fee_transactions.json
  def index
    @fee_transactions = policy_scope(FeeTransaction)
    authorize FeeTransaction
  end

  # GET /fee_transactions/1
  # GET /fee_transactions/1.json
  def show
    authorize @fee_transaction
  end

  # GET /fee_transactions/new
  def new
    @fee_transaction = FeeTransaction.new
    @fee_transaction.fee_id = params[:fee_id]
    @fee_transaction.transaction_type = params[:transaction_type]
    @fee_transaction.apartment_id = $current_apartment.id
    authorize @fee_transaction
  end

  # GET /fee_transactions/1/edit
  def edit
    authorize @fee_transaction
  end

  # POST /fee_transactions
  # POST /fee_transactions.json
  def create
    @fee_transaction = FeeTransaction.new(fee_transaction_params)
    authorize @fee_transaction 

    respond_to do |format|
      if @fee_transaction.save
        format.html { redirect_to @fee_transaction, notice: 'Fee transaction was successfully created.' }
        format.json { render :show, status: :created, location: @fee_transaction }
      else
        format.html { render :new }
        format.json { render json: @fee_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fee_transactions/1
  # PATCH/PUT /fee_transactions/1.json
  def update
    authorize @fee_transaction
    respond_to do |format|
      if @fee_transaction.update(fee_transaction_params)
        format.html { redirect_to @fee_transaction, notice: 'Fee transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @fee_transaction }
      else
        format.html { render :edit }
        format.json { render json: @fee_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fee_transactions/1
  # DELETE /fee_transactions/1.json
  def destroy
    authorize @fee_transaction 
    @fee_transaction.destroy
    respond_to do |format|
      format.html { redirect_to fee_transactions_url, notice: 'Fee transaction was successfully destroyed.' }
      format.json { head :no_content }
      format.js   
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee_transaction
      @fee_transaction = FeeTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_transaction_params
      params.require(:fee_transaction).permit(:start_date, :end_date, :transaction_type, :value, :fee_id, :apartment_id)
    end
end
