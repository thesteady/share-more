require 'spec_helper'

describe Article do 
  let(:valid_title){"article title"}
  let(:invalid_body){"invalid article body"}
  let(:valid_body){"article body"}
  let(:valid_article) do 
    { 
      :title => valid_title, 
      :revisions_attributes => [
        { body: invalid_body },
        { body: valid_body }
        ]
      }
  end

  describe '.accepts_nexted_attributes' do 
    it 'should create an article, and build a revision' do 
      article = create_user.articles.create(valid_article)
      expect(article.title).to eq valid_title
      expect(article.body).to eq valid_body
    end
  end

  it 'should'
  
end
