class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= find_user_by_session
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

end
