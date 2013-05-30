require 'spec_helper'

describe OauthsController do

  describe "GET 'oauth'" do
    it "returns http success" do
      VCR.use_cassette("get_oauth") do
        get 'oauth'
        response.should be_redirect
      end
    end
  end
end
