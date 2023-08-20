class ApplicationController < ActionController::API
  include JsonWebToken
  include ApiWebToken

  helper_method :current_user
  before_action :authenticate_request

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_request
    header = request.headers["Authorization"]
    begin
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :bad_request
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :bad_request
    end
  end
end
