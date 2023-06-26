class Api::V1::UsersController < ApplicationController
  before_action :format_email, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render json: { "success": "User added successfully" }, status: :created
    else
      render json: { "errors": user.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def show
    @user = User.find_by(email: user_params[:email])
    if @user&.authenticate(user_params[:password])
      render json: UserSerializer.users([@user])
    else
      render json: { "errors": "Unable to locate or authenticate user" }, status: :not_found
    end
  end

  private

  def format_email
    params[:email]&.downcase!
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
