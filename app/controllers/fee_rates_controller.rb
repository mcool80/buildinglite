class FeeRatesController < ApplicationController
  before_action :set_fee_rate, only: [:show, :edit, :update, :destroy]

  # GET /fee_rates
  # GET /fee_rates.json
  def index
    @fee_rates = FeeRate.all
  end

  # GET /fee_rates/1
  # GET /fee_rates/1.json
  def show
  end

  # GET /fee_rates/new
  def new
    @fee_rate = FeeRate.new
  end

  # GET /fee_rates/1/edit
  def edit
  end

  # POST /fee_rates
  # POST /fee_rates.json
  def create
    @fee_rate = FeeRate.new(fee_rate_params)

    respond_to do |format|
      if @fee_rate.save
        format.html { redirect_to @fee_rate, notice: 'Fee rate was successfully created.' }
        format.json { render :show, status: :created, location: @fee_rate }
      else
        format.html { render :new }
        format.json { render json: @fee_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fee_rates/1
  # PATCH/PUT /fee_rates/1.json
  def update
    respond_to do |format|
      if @fee_rate.update(fee_rate_params)
        format.html { redirect_to @fee_rate, notice: 'Fee rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @fee_rate }
      else
        format.html { render :edit }
        format.json { render json: @fee_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fee_rates/1
  # DELETE /fee_rates/1.json
  def destroy
    @fee_rate.destroy
    respond_to do |format|
      format.html { redirect_to fee_rates_url, notice: 'Fee rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee_rate
      @fee_rate = FeeRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_rate_params
      params.require(:fee_rate).permit(:start_date, :end_date, :rate_apartment, :rate_cost, :fee_id)
    end
end
