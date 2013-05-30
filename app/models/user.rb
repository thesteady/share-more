class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :token, :username

  has_many :api_keys
  has_many :articles

  has_one :access_token

  def self.find_or_create(user_args)
    self.find_from_service(user_args) || self.create_from_service(user_args)
  end

  def self.find_from_service(user)
    self.find_by_username(user.screen_name)
  end

  def self.create_from_service(user)
    user = self.create(username: user.screen_name, token: user.user_id)
    user.create_access_token(
      token: user.oauth_token,
      secret: user.oauth_token_secret
      )
    user
  end

  after_create :build_first_key

  def active_key
    self.api_keys.active.limit(1).first
  end

  def active_token
    active_key.access_token
  end

  def build_key
    self.api_keys.create(expired: false)
  end

  def expire_old_keys_and_build_new_key
    self.api_keys.active.each(&:deactivate)
    self.build_key
  end

private

  def build_first_key
    unless self.api_keys.count > 0
      build_key
    end
  end
end
