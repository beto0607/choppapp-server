class ApplicationController < ActionController::API
  def not_found
    render json: { error: "not_found" }
  end

  def authorize_request
    header = authorization_header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def admin_request
    render json: { errors: ["User should be an admin"] }, status: :unauthorized unless @current_user.is_admin
  end

  def admin_request?
    @current_user.is_admin
  end

  def authorization_header
    request.headers["Authorization"].split(" ").last if request.headers["Authorization"]
  end
end
