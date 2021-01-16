class ApplicationController < ActionController::API
  def check_auth
    if not session[:user_id]
      render json: { error: "Authentication needed" }, status: 401
    end
  end

  # checks if there's a current user, potentially use this for update?
  #   def current_user
  #     return unless session[:user_id]
  #     @current_user ||= User.find(session[:user_id])
  #   end
end
