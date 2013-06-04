class Article < ActiveRecord::Base
  attr_accessible :title, :body, :unique_url
  belongs_to :user

  before_create :generate_url
  validates_uniqueness_of :unique_url

  def as_json(options)
    super(
  :except =>  [:unique_url, :updated_at, :user_id, :id], 
  :methods => [:article_id,:url]
  )
  end

  def self.options
    root = 'http://share-more.herokuapp.com/api/v1/'
    [{"create_article" => "#{root}articles?access_token={YOUR ACCESS_TOKEN}&article={title: TITLE, body: BODY}"},
      {"get_article" => "#{root}articles/{ARTICLE_ID}"},
      {"get_all_articles" => "#{root}articles?access_token={YOUR ACCESS_TOKEN}"}]
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

  def to_param
    unique_url
  end

  def generate_url
    begin
      self.unique_url = SecureRandom.urlsafe_base64(5)
    end while self.class.exists?(unique_url: unique_url)
  end

end
