class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  def index
    authorize User
    @users = current_user.community.users
  end
 
  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  # Connect user to apartment
  # If user doesn't exist, create user
  # POST /connect
  def connect
    @user = User.where(:email => params[:user][:email]).first
    # If there is no user, create one
    if @user.nil? then
      @user = User.new(user_params)
    end
    authorize @user
    @user.apartment_id = params[:user][:apartment_id]
    respond_to do |format|
      if @user.save!
        format.html { redirect_to @user, notice: 'User was successfully connected.' }
        format.json { render :show, status: :connected, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_user = @user
    if not params[:user][:apartment_id].nil? and @user.apartment.nil? then
      update_user.apartment_id = params[:user][:apartment_id]
    end
    authorize update_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:password, :email, :last_name, :first_name, :mobile, :phone, :apartment_id, :password_confirmation)
    end
end
