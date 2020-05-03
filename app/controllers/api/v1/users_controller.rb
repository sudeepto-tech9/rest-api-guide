class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # Get /users
  def index
    @users = User.all
    render json: @users
  end

  # Get /user/:id
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { error: "Unable to create User." }, status: 400
    end
  end

  # PUT /users/:id
  def update
    if @user.valid?
      @user.update(user_params)
      render json: { message: "User successfully updated." }, status: 200
    else
      render json: { error: "Unable to update User." }, status: 400
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.valid?
      @user.destroy
      render json: { message: "User successfully deleted."}, status: 200
    else
      render json: { error: "Unable to delete User."}, status: 400
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
