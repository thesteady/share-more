class OauthsController < ApplicationController
  
  def oauth
    client = OauthService.prepare
    request_token = client.request_token(:oauth_callback => OauthService.url)
    session[:request_token_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end
      
  def callback
    client = OauthService.prepare
    access_token = client.authorize(
        session[:request_token_token],
        session[:request_token_secret],
        :oauth_verifier => params[:oauth_verifier])

'#<OAuth::AccessToken:0x00000002a5adc8 
@token="14828267-E2PIDjyRAfxbDvMzSbR1eWd0Um0PUadsguojX2SWc",
@secret="ulG0bOn7nZJYrK4kf5y8mzcySeHNrEOZJc1rfXVxqbA", 
@consumer=#<OAuth::Consumer:0x00000002b71518 
@key="hs9cu12SxUUooBCVMUuw", 
@secret="VoTNZhUFyPhhuWK5abwj7O7jYGb81w96zLD8WOsN2Y", 
@options={:signature_method=>"HMAC-SHA1", :request_token_path=>"/oauth/request_token", :authorize_path=>"/oauth/authorize", :access_token_path=>"/oauth/access_token", :proxy=>nil, :scheme=>:header, :http_method=>:post, :oauth_version=>"1.0", :site=>"http://api.twitter.com", :request_endpoint=>nil}, 
@http_method=:post, 
@http=#<Net::HTTP api.twitter.com:80 open=false>>, 
@params={
  :oauth_token=>"14828267-E2PIDjyRAfxbDvMzSbR1eWd0Um0PUadsguojX2SWc",
  "oauth_token"=>"14828267-E2PIDjyRAfxbDvMzSbR1eWd0Um0PUadsguojX2SWc", 
  :oauth_token_secret=>"ulG0bOn7nZJYrK4kf5y8mzcySeHNrEOZJc1rfXVxqbA",
  "oauth_token_secret"=>"ulG0bOn7nZJYrK4kf5y8mzcySeHNrEOZJc1rfXVxqbA",
  :user_id=>"14828267",
  "user_id"=>"14828267",
  :screen_name=>"blairanderson"
'
    
    Rails.logger.info("access_token: #{access_token.inspect}")
    Rails.logger.info("access_token_params: #{access_token.params}")
    Rails.logger.info("access_token: #{access_token.params[:user_id]}")
    Rails.logger.info("access_token: #{access_token.params[:screen_name]}")
    Rails.logger.info("access_token: #{access_token.params[:oauth_token]}")
    
    token = params["oauth_token"]
    verifier = params["oauth_verifier"]
    if @user = User.find_or_create({token: token, verifier: verifier})
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
