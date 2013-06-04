class ApplicationController < ActionController::Base
  protect_from_forgery

  #1) Should API routes be separated from the main routes?

#yes. Make a namespace, it will make the api implementation more clear. 

  #2) What should i be saving from each API request? something about saving the request time so that it cannot be duplicated?  

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
