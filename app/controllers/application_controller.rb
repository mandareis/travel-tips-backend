class ApplicationController < ActionController::API
  def check_auth
    if not session[:user_id]
      render json: { :error => "Authentication needed" }, status: 401
    end
  end
  def previous_page
    current_page > 1 ? (current_page - 1) : nil
  end
  def next_page
    current_page < total_pages ? (current_page + 1) : nil
  end
end
