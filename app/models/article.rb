class Article < ActiveRecord::Base
  attr_accessible :title, :body, :published, :unique_url, :revisions_attributes
  belongs_to :user

  has_many :revisions, :order => "created_at DESC"

  accepts_nested_attributes_for :revisions, :allow_destroy => true

  scope :published, where( :published => 1 )
  scope :drafts, where( :published => 0 )

  before_create :generate_url
  validates_uniqueness_of :unique_url

  def as_json(options)
    super(
  :except =>  [:unique_url, :updated_at, :user_id, :id], 
  :methods => [:article_id,:url,:body]
  )
  end

  def article_id
    read_attribute(:unique_url)
  end

  def published
    publish_key read_attribute(:published)
  end

  def url
    if Rails.env.production?
      host = "http://share-more.herokuapp.com/"
    else
      host = "http://0.0.0.0:3000/"
    end
    host + unique_url
  end

  def body
    revisions.first.body
  end

  def to_param
    unique_url
  end

  def generate_url
    begin
      self.unique_url = SecureRandom.urlsafe_base64(5)
    end while self.class.exists?(unique_url: unique_url)
  end

  def publish_key(input)
    {
      1 => "true",
      0 => "false"
      }[input]
  end

end
