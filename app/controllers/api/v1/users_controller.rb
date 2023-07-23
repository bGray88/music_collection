class Api::V1::UsersController < ApplicationController
  before_action :format_email,  only: [:create]
  before_action :find_user,     only: [:show]
  skip_before_action :authenticate_request, only: [:create]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { "success": "User added successfully", "user": @user }, status: :created
    else
      render json: { "errors": @user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    render json: UserSerializer.users([@user])
  end

  def update
    if @user.update(user_params)
      render json: { "success": "User updated successfully", "user": @user }, status: :ok
    else
      render json: { "errors": @user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @user.destroy
  end

  private

  def format_email
    params[:email]&.downcase!
  end

  def find_user
    @user = @_current_user
  end

  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation
    )
  end
end
