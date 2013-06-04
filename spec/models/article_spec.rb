require 'spec_helper'

describe Article do 
  let(:valid_title){"article title"}
  let(:invalid_body){"invalid article body"}
  let(:valid_body){"article body"}
  let(:valid_article) do
    { title: valid_title, body: valid_body}
  end

  describe '.options' do 
    it 'should return a hash of API options' do 
      root = 'http://share-more.herokuapp.com/api/v1/'
      options = {
    links: [
    {"create_article" => "#{root}articles?access_token={YOUR ACCESS_TOKEN}&article={title: TITLE, body: BODY}"},
    {"get_article" => "#{root}articles/{ARTICLE_ID}"},
    {"get_all_articles" => "#{root}articles?access_token={YOUR ACCESS_TOKEN}"}
  ]
  }
      expect(Article.options).to eq options
    end

  end

end
