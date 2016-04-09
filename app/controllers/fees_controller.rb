class FeesController < ApplicationController
  before_action :authenticate_user!, :set_globals
  before_action :set_fee, only: [:show, :edit, :update, :destroy]

  # GET /fees
  # GET /fees.json
  def index
    @fees = policy_scope(Fee)
    authorize Fee
  end

  # GET /fees/1
  # GET /fees/1.json
  def show
    authorize @fee
  end

  # GET /fees/new
  def new
    authorize Fee
    @fee = Fee.new
  end

  # GET /fees/1/edit
  def edit
    authorize @fee
  end

  # POST /fees
  # POST /fees.json
  def create
    @fee = Fee.new(fee_params)
    authorize @fee

    respond_to do |format|
      if @fee.save
        format.html { redirect_to @fee, notice: 'Fee was successfully created.' }
        format.json { render :show, status: :created, location: @fee }
      else
        format.html { render :new }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fees/1
  # PATCH/PUT /fees/1.json
  def update
    authorize @fee
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to @fee, notice: 'Fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @fee }
      else
        format.html { render :edit }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1
  # DELETE /fees/1.json
  def destroy
    authorize @fee
    @fee.destroy
    respond_to do |format|
      format.html { redirect_to fees_url, notice: 'Fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @fee = Fee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_params
      params.require(:fee).permit(:name, :payment_interval, :currency, :unit, :community_id)
    end
end
