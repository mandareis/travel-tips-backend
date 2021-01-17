class ApplicationController < ActionController::API
  def check_auth
    if not session[:user_id]
      render json: { :error => "Authentication needed" }, status: 401
    end
  end
end
