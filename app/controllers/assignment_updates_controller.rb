class AssignmentUpdatesController < ApplicationController
  before_action :authenticate_user!, :set_globals
  before_action :set_assignment_update, only: [:show, :edit, :update, :destroy]
  before_action :set_assignments, only: [:edit, :new]

  # GET /assignment_updates
  # GET /assignment_updates.json
  def index
    authorize AssignmentUpdate
    @assignment_updates = AssignmentUpdate.joins(:assignment).where(:assignments => { :community_id => $current_community.id })
  end

  # GET /assignment_updates/1
  # GET /assignment_updates/1.json
  def show
    authorize @assignment_update 
  end

  # GET /assignment_updates/new
  def new
    @assignment_update = AssignmentUpdate.new
    authorize @assignment_update 
  end

  # GET /assignment_updates/1/edit
  def edit
    authorize @assignment_update 
  end

  # POST /assignment_updates
  # POST /assignment_updates.json
  def create
    @assignment_update = AssignmentUpdate.new(assignment_update_params)
    authorize @assignment_update 

    respond_to do |format|
      if @assignment_update.save
        format.html { redirect_to @assignment_update, notice: t(:success, :model => AssignmentUpdate.model_name.human) }
        format.json { render :show, status: :created, location: @assignment_update }
      else
        format.html { render :new }
        format.json { render json: @assignment_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignment_updates/1
  # PATCH/PUT /assignment_updates/1.json
  def update
    authorize @assignment_update 
    respond_to do |format|
      if @assignment_update.update(assignment_update_params)
        format.html { redirect_to @assignment_update, notice: t(:updated, :model => AssignmentUpdate.model_name.human) }
        format.json { render :show, status: :ok, location: @assignment_update }
      else
        format.html { render :edit }
        format.json { render json: @assignment_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment_updates/1
  # DELETE /assignment_updates/1.json
  def destroy
    authorize @assignment_update 
    @assignment_update.destroy
    respond_to do |format|
      format.html { redirect_to assignment_updates_url, notice: t(:destroyed, :model => AssignmentUpdate.model_name.human) }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment_update
      @assignment_update = AssignmentUpdate.find(params[:id])
    end

    def set_assignments
      @assignments = Assignment.where(community_id: $current_community.id).where.not(close_date: nil)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_update_params
      params.require(:assignment_update).permit(:update_text, :assignment_id)
    end
end
