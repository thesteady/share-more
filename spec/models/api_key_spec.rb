require 'spec_helper'

describe ApiKey do
  describe 'validations' do 
    let(:api_key) do 
      create_api_key
    end

    let(:author)do 
      api_key.author
    end

    before(:each) do 
      expect(api_key).to be_valid
      expect(author).to be_valid
    end

    it 'should have an author' do 
      api_key.author_id = nil
      api_key.save
      expect(api_key).to be_invalid
    end

    it 'should have a unique access_token' do 
      token = api_key.access_token
      another_key = author.api_keys.create!(expired: false)
      expect(another_key).to be_valid

      another_key.access_token = token
      another_key.save
      expect(another_key).to be_invalid
    end

    it 'should be invalid without expired' do 
      api_key.expired = nil
      expect(api_key).to be_invalid
    end

    it 'creating a new key should expire other keys for the same user' do 
      expect(api_key.expired).to eq false
      author = api_key.author
      expect(author).to be_valid

      new_key = author.api_keys.create!(expired: false)

      expect(new_key.author).to eq author
      expect(new_key.expired).to eq false

      expect(ApiKey.find(new_key.id).expired).to eq false
    end
    describe '#deactivate' do
      it 'should flip the expired attribute from false to true' do
        expect(api_key.expired).to eq false
        api_key.deactivate
        expect(api_key.expired).to eq true
        api_key.deactivate
        expect(api_key.expired).to eq true
      end
    end

  end
end
