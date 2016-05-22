class AssignmentsController < ApplicationController
  before_action :authenticate_user!, :set_globals
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :close]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = $current_community.assignments.where(:close_date => nil).joins(:assignment_status) 
    @users = $current_community.users
    authorize Assignment
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    authorize @assignment
    @assignment_updates = AssignmentUpdate.where(assignment_id: @assignment.id)
    @assignment_update = AssignmentUpdate.new
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
    @assignment.community_id = $current_community.id
    @users = $current_community.users
    last_assignment =  Assignment.where(:community_id => $current_community.id).order(no: :desc).first
    if not last_assignment.nil? then
      @assignment.no = last_assignment.no + 1
    end
    authorize @assignment
  end

  # GET /assignments/1/edit
  def edit
    @users = $current_community.users
    authorize @assignment
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    authorize @assignment

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    authorize @assignment
    if not @assignment.assignment_status.close_state then
      @assignment.close_date = nil
    end
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    authorize @assignment
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /assignment/close/1
  # POST /assignment/close/1.json
  def close
    authorize @assignment
    @assignment.close_date = Date.today
    close_status = $current_community.assignment_status_close
    if not close_status.nil? then 
      @assignment.assignment_status_id = close_status.id
    end
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to assignments_url, notice: 'Assignment was successfully closed.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { redirect_to assignments_url, notice: 'Assignment was not closed.' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  def closed_list
    @assignments = $current_community.assignments.where.not(:close_date => nil).joins(:assignment_status)
    @users = $current_community.users
    authorize Assignment
  end

  def latest_updates
    @assignments = $current_community.assignments.where(:close_date => nil)
    authorize Assignment
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:no, :reference, :text, :status_id, :duedate, :user_id, :comment, :community_id, :assignment_status_id, :close_date)
    end
end
