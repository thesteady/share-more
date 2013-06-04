require 'spec_helper'

describe Api::V1::ArticlesController do

  let(:article){create_article}
  let(:user){article.user}

  let(:valid_article_title){"Article Title"}
  let(:valid_article_body){"Article Body"}
  let(:valid_article_params) do
    {title: valid_article_title, body: valid_article_body}
  end

  describe "GET 'show'" do
    it "assigns article that is requested" do
      get 'show', id: article.unique_url
      expect(assigns(:article)).to eq article
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success and article URL and ID" do
      post 'create', 
          article: valid_article_params, 
          access_token: user.active_token

      response_article = JSON.parse(response.body)
      expect(response_article["title"]).to eq valid_article_title
      expect(response_article["body"]).to eq valid_article_body
      expect(response_article["article_id"]).to be
      expect(response_article["url"]).to be
      response.should be_success
    end
  end


  describe "GET 'index'" do
    it "returns http success" do
      get 'index', access_token: user.active_token
      response.should be_success 
      expect(assigns(:articles)).to eq [article]
    end
  end
  
end
