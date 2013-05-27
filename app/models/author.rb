class Author < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_presence_of :username, :email

  validates_uniqueness_of :username , :case_sensitive => false
  validates_uniqueness_of :email    , :case_sensitive => false
  
  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password

  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  has_many :api_keys

  # has_one :active_key, :class_name => "ApiKey", :conditions => "author_id = self.id, expired = false, limit=1"

  after_create :build_first_key

  def active_token
    self.api_keys.active.limit(1).first.access_token
  end


private

  def build_first_key
    self.api_keys.create(expired: false)
  end

  # def valid_api
  #   key = ApiKey.where(author_id: id, expired: false).order("created_at ASC").first_or_
  # end
end
