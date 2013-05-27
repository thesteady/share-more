class ApiKey < ActiveRecord::Base
  attr_accessible :expired
  belongs_to :author

  # def valid?
  #   self.expired == false
  # end

  validates_presence_of :author_id
  validates :expired, :inclusion => { :in => [true, false] }

  before_create :generate_access_token
  validates_uniqueness_of :access_token
  
  scope :active,  where(:expired=> false)

private

  # after_create :expire_old_keys_per_author
  # def expire_old_keys_per_author### this is super broken`

    # ApiKey.where(:author_id => self.author_id, :expired => false).order("created_at DESC").offset(1).each do |api_key| 
    #   api_key.expired = true
    #   api_key.save
    # end
  
    # ApiKey.where(:author_id => self.author_id, :expired => false).order("created_at DESC").offset(1).update_all(:expired => true)
  # end

  # def valid
    
  # end

  def generate_access_token
    begin
      self.access_token = SecureRandom.urlsafe_base64(24)
    end while self.class.exists?(access_token: access_token)
  end

end
