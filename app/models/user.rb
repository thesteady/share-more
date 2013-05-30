class User < ActiveRecord::Base
  attr_accessible :username, :email, :full_name, :token

  has_many :api_keys
  has_many :articles

  has_one :access_token

  validates_presence_of :username
  validates_uniqueness_of :username, :email

  def self.find_or_create(user_args)
    self.find_from_service(user_args) || self.create_from_service(user_args)
  end

  def self.find_from_service(user_args)
    self.find_by_username(user_args.screen_name) || false
  end

  def self.create_from_service(user_args)
    user = self.create!(username: user_args.screen_name, token: user_args.user_id)
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
