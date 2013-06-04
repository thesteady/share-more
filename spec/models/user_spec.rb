require 'spec_helper'

describe User do 
  context 'validations' do 
    let(:user) do
      create_user
    end

    before do
      expect(user).to be_valid
    end

    it 'requires a username' do
      user.username = nil
      expect(user).to be_invalid
    end

    it 'should not allow duplicate usernames' do
      another_user = create_user(username: "taco", email:"new@email.com")
      expect(another_user).to be_valid

      expect(user.username).to eq 'username'
      
      another_user.username = 'username'
      another_user.save
      expect(another_user).to be_invalid
    end
  end

  context 'creating users from the service' do 
    let(:valid_oauth_args) do 
    end
    describe '.find_or_create' do 
      it 'should find or create a user from the service auth'
      it 'should break properly if the service is down'
    end

    describe '.find_from_service' do 
      it 'should find the user if they exist'
      it 'should return nil if they do not exist'
    end

    describe '.create_from_service' do 
      it 'should create a user from the service provider'
      it 'should fallback properly if given bad data'
    end
  end

  describe '#api_keys' do 
    let(:user) do
      create_user
    end
    describe '#build_first_key' do 
      it 'should create an api_key after the user is first created' do 
        expect(user.api_keys.first.class).to eq ApiKey
        expect(User.count).to eq 1
        expect(ApiKey.count).to eq 1
        expect(User.first.api_keys.first.id).to eq ApiKey.first.id
        expect(user.api_keys.first.access_token.class).to eq String
      end
    end

    describe '#expire_old_keys_and_build_new_key' do
      it 'should expire old keys and build a new one' do
        count = 5 
        count.times do
          user.build_key
        end
        expect(ApiKey.count).to eq count+1
        expect(user.api_keys.count).to eq count+1
        expect(user.api_keys.active.count).to eq count+1

        key = user.expire_old_keys_and_build_new_key
        expect(key.expired).to eq false
        expect(user.api_keys.active.count).to eq 1
      end
    end

    describe '#active_token' do
      it 'should return the access_token of the active-key' do
        expect(user.api_keys.first.access_token.class).to eq String
        expect(user.active_token).to eq user.api_keys.active.first.access_token
      end
    end
  end
end
