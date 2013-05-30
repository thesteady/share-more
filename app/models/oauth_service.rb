class OauthService
  def self.prepare
    TwitterOAuth::Client.new(
      :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
      :consumer_secret => ENV['TWITTER_CONSUMER_SECRET']
      )
  end
end
