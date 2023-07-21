class Api::V1::SessionsController < ApplicationController
  before_action :format_email, only: [:create]
  before_action :find_user,    only: [:create]
  skip_before_action :authenticate_request, only: [:create]

  def create
    if @user&.authenticate(login_params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { "success": "Logged in successfully", token: token }, status: :ok
    else
      render json: { "errors": "Unable to locate or authenticate user" }, status: :not_found
    end
  end

  def destroy
    render json: { "success": "Logged out successfully" }, status: :ok
  end

  private

  def format_email
    login_params[:email]&.downcase!
  end

  def find_user
    @user = User.find_by(email: login_params[:email])
  end

  def login_params
    params.require(:login).permit(
      :email,
      :password
    )
  end
end
