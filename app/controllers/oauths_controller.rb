class OauthsController < ApplicationController
  
  def oauth
    client = OauthService.prepare
    request_token = client.request_token(:oauth_callback => OauthService.url)
    session[:request_token_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end
      
  def callback
    Rails.logger.info("PARAMS: #{params.inspect}")
    client = OauthService.prepare
    access_token = client.authorize(
        session[:request_token_token],
        session[:request_token_secret],
        :oauth_verifier => params[:oauth_verifier])
    
    Rails.logger.info("ACCESS_TOKEN: #{access_token.params}")
    
    user_args = OauthService.new(access_token.params)
    
    if @user = User.find_or_create(user_args)
      login(@user)
      redirect_to root_path, :notice => "Logged in from Twitter!"
    else
      redirect_to root_path, :alert => "Failed to login from twitter!"
    end
  end

  def login(user)
    session[:user_id] = user.id
  end
end
