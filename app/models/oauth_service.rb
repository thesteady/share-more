class OauthService
  attr_reader :user_id, :screen_name, :oauth_token, :oauth_token_secret

  def initialize(args)
    @user_id = args[:user_id]
    @screen_name = args[:screen_name]
    @oauth_token = args[:oauth_token]
    @oauth_token_secret = args[:oauth_token_secret]
  end

  def self.prepare
    TwitterOAuth::Client.new(
      :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
      :consumer_secret => ENV['TWITTER_CONSUMER_SECRET']
      )
  end

  def self.url
    if Rails.env.production?
      "http://share-more.herokuapp.com/oauth/callback"
    else
      "http://0.0.0.0:3000/oauth/callback"
    end
  end
end
