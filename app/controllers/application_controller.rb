class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @user ||= (find_by_access_token || find_user_by_session)
  end

  def find_user_by_session
    User.find_by_id(session[:user_id])
  end

  def find_by_access_token
    if key = ApiKey.find_by_access_token(params[:access_token])
      key.user
    end
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to root_path, notice: "Must be logged in"
    end
  end
end
