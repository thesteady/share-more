class ApiKey < ActiveRecord::Base
  attr_accessible :expired
  belongs_to :user

  validates_presence_of :user_id
  validates :expired, :inclusion => { :in => [true, false] }

  before_create :generate_access_token
  validates_uniqueness_of :access_token
  
  scope :active,  where(:expired=> false).order("created_at DESC")
  scope :inactive,  where(:expired=> true).order("created_at DESC")

  def deactivate
    unless self.expired == true
      self.toggle(:expired)
      self.save
    end
  end

private
  def generate_access_token
    begin
      self.access_token = SecureRandom.urlsafe_base64(24)
    end while self.class.exists?(access_token: access_token)
  end

end
