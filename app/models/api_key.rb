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

  after_create :expire_old_keys_per_author

  
private

  def expire_old_keys_per_author### this is super broken`
    ApiKey.where( #### Does This Skip Validation??? ### 
      :author_id == self.author_id,
      :expired == false,
      :id != self.id).update_all(:expired => true)

    # ApiKey.where(:author_id == self.author_id, :expired == false, :id != self.id).each do |api_key| 
    #     api_key.expired = true
    #     api_key.save
    #   end
  end

  # def valid
    
  # end

  def generate_access_token
    begin
      self.access_token = SecureRandom.urlsafe_base64(24)
    end while self.class.exists?(access_token: access_token)
  end

end
