class User < ActiveRecord::Base
  attr_accessible :email, :full_name, :token, :username

  has_many :api_keys
  has_many :articles

  def self.find_or_create(stuff)
    self.find_from_service(stuff) || self.create_from_service(stuff)
  end

  def self.find_from_service(stuff)
    false
  end

  def self.create_from_service(stuff)
    User.create
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
