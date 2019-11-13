class UsersController < ApplicationController
  before_action :authorize_request, only: [:index, :destroy]
  before_action :admin_request, only: [:index]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if authorization_header then
      authorize_request
    end
    if !@user.is_private || (@current_user && @current_user.id == @user.id) then
      render json: @user, status: :ok
    else
      head :no_content
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if admin_request? || @user.id == @current_user.id then
      @user.destroy
      head :no_content
    else
      render json: {errors: ""}, status: :forbidden
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "User not found" }, status: :not_found
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password_digest)
  end
end
