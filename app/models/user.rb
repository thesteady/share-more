class User < ActiveRecord::Base
  attr_accessible :username, :email, :full_name, :twitter_id

  has_many :api_keys
  has_many :articles, :order => "created_at DESC"

  has_one :access_token

  validates_presence_of :username
  validates_uniqueness_of :username

  def self.find_or_create(user_args)
    self.find_from_service(user_args) || self.create_from_service(user_args)
  end

  def self.find_from_service(user_args)
    self.find_by_username(user_args.screen_name) || false
  end

  def self.create_from_service(user_args)
    user = self.create!(username: user_args.screen_name, twitter_id: user_args.user_id.to_i)
    user.create_access_token!(
      token: user_args.oauth_token,
      secret: user_args.oauth_token_secret
      )
    user
  end

  after_create :build_first_key

  def active_key
    self.api_keys.active.limit(1).first
  end

  def active_token
    if active_key
      result = active_key.access_token
    else
      build_key
      result = active_key.access_token
    end
    result
  end

  def active_secret
    if active_key
      result = active_key.secret_token
    else
      build_key
      result = active_key.secret_token
    end
    result
  end

  def build_key
    self.api_keys.create(expired: false)
  end

  def expire_old_keys_and_build_new_key
    self.api_keys.active.each(&:deactivate)
    self.build_key
  end

private

  def most_recent_article
    article ||= articles.first
  end

  def build_first_key
    unless self.api_keys.count > 0
      build_key
    end
  end
  
end
