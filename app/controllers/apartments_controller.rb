class ApartmentsController < ApplicationController
  before_action :authenticate_user!, :set_globals
  before_action :set_apartment, :only => [:show, :showinfo, :edit, :destroy, :update]

  # GET /apartments
  # GET /apartments.json
  def index
    authorize Apartment
    @apartments = Apartment.where(:community_id => $current_community.id).order(:address)
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
    authorize @apartment
    @fees = Fee.where(:community_id => $current_community.id)
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def showinfo
    authorize @apartment
    @fees = Fee.where(:community_id => $current_community.id)
  end

  # GET /apartments/new
  def new
    authorize Apartment
    @apartment = Apartment.new
  end

  # GET /apartments/1/edit
  def edit
    authorize @apartment
  end

  # POST /apartments
  # POST /apartments.json
  def create
    @apartment = Apartment.new(apartment_params)
    authorize @apartment

    respond_to do |format|
      if @apartment.save
        format.html { redirect_to @apartment, notice: 'Apartment was successfully created.' }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    authorize @apartment
    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    authorize @apartment
    @apartment.destroy
    respond_to do |format|
      format.html { redirect_to apartments_url, notice: 'Apartment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_apartment
      @apartment = $current_apartment
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:address, :apartment_no, :community_id, :moved)
    end
end
