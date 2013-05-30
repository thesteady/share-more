class OauthsController < ApplicationController
  
  def oauth
    client = OauthService.prepare
    if Rails.env.production?
      oauth_confirm_url = "http://tweetgists.herokuapp.com/oauth/callback"
    else
      oauth_confirm_url = "localhost:3000/oauth/callback"
    end
    request_token = client.request_token(:oauth_callback => oauth_confirm_url)
    redirect_to request_token.authorize_url
  end
      
  def callback
    Rails.logger.info("PARAMS: #{params.inspect}")

    if @user = User.find_or_create(params)
      login(user)
      redirect_to root_path, :notice => "Logged in from Twitter!"
    else
      redirect_to root_path, :alert => "Failed to login from twitter!"
    end
  end

  def login(user)
    session[:user_id] = user.id
  end
end
