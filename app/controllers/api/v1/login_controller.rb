class Api::V1::LoginController < ApplicationController
  def create
    user = User.find_by(email: login_params[:email])
    if user&.authenticate(login_params[:password])
      session[:user_id] = user.id
    else
      render json: { "errors": "Unable to locate or authenticate user" }, status: :not_found
    end
  end

  def destroy
    reset_session
    render json: { "success": "Logged out successfully" }, status: :created
  end

  private

  def login_params
    params.require(:login).permit(
      :email,
      :password
    )
  end
end
