class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    User.first
  end

  def logged_in?
    false
  end
end
