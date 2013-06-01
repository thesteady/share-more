class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= find_by_access_token || find_user_by_session
  end

  def logged_in?
    !!current_user
  end

  def require_login
    if !logged_in?
      redirect_to new_path, notice: "Must be logged in"
    end
  end

  def find_user_by_session
    User.find_by_id(session[:user_id])
  end

  def find_by_access_token
    if key = ApiKey.active.find_by_access_token(params[:access_token])
      key.user
    end
  end

end
