require 'spec_helper'

describe Author do 
  context 'validations' do 
    let(:author) do
      create_author
    end

    before do
      expect(author).to be_valid
      # expect(author.api_keys.first).to be_valid
    end

    it 'requires a username' do 
      author.username = nil
      expect(author).to be_invalid
    end

    it 'requires an email' do
      author.email = nil
      expect(author).to_not be_valid
    end      
    it 'should not allow duplicate usernames' do
      another_author = create_author(username: "taco", email:"new@email.com")
      expect(another_author).to be_valid

      expect(author.username).to eq 'username'
      another_author.username = "username"
      another_author.save
      expect(another_author).to be_invalid
    end

    it 'should not allow duplicate email' do 
      another_author = create_author(username: "taco", email:"new@email.com")
      expect(another_author).to be_valid

      expect(author.email).to eq 'example@example.com'
      another_author.email = 'example@example.com'
      another_author.save
      expect(another_author).to be_invalid
    end
  end

  describe '#api_keys' do 
    let(:author) do
      create_author
    end

    describe '#build_first_key' do 
      it 'should create an api_key after the Author is first created' do 
        expect(author.api_keys.first).to be_kind_of ApiKey
        expect(author.api_keys.first.class).to eq ApiKey
        expect(Author.count).to eq 1
        expect(ApiKey.count).to eq 1
        expect(Author.first.api_keys.first.id).to eq ApiKey.first.id
        expect(author.api_keys.first.access_token.class).to eq String
      end
    end

    describe '#active_token' do
      it 'should return the access_token of the active-key' do

        expect(author.api_keys.first.access_token).to eq String
        expect(author.active_token).to eq author.api_keys.first.access_token
      end

      it 'only the most recent should not be expired'
    end
  end
end
