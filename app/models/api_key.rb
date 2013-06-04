class ApiKey < ActiveRecord::Base
  attr_accessible :expired
  belongs_to :user

  validates_presence_of :user_id
  validates :expired, :inclusion => { :in => [true, false] }

  before_create :generate_tokens
  validates_uniqueness_of :access_token
  validates_uniqueness_of :secret_token
  
  scope :active,  where(:expired => false).order("created_at DESC")
  scope :inactive,  where(:expired => true).order("created_at DESC")

  def deactivate
    if self.expired == false
      self.toggle(:expired)
      self.save
    end
  end

private

  def generate_tokens
    ApiKey.transaction do 
      generate_access_token
      generate_secret_token
    end
  end

  def generate_secret_token
    begin
      self.secret_token = SecureRandom.urlsafe_base64(12)
    end while self.class.exists?(secret_token: secret_token)
  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.urlsafe_base64(8)
    end while self.class.exists?(access_token: access_token)
  end

end
