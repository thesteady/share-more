class Author < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_presence_of :username, :email

  validates_uniqueness_of :username , :case_sensitive => false
  validates_uniqueness_of :email    , :case_sensitive => false
  
  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password

  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  has_many :api_keys

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
