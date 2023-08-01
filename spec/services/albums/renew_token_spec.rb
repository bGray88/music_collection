require 'rails_helper'

RSpec.describe 'Albums Service' do
  describe "Renew Token" do
    it 'can renew token through API' do
      auth_response = AlbumsService.renew_auth_token

      expect(auth_response[:access_token]).to be_a(String)
      expect(auth_response[:access_token].length).to be >(30)
      expect(auth_response[:expires_in]).to be_a(Integer)
      expect(auth_response[:token_type]).to eq("Bearer")
    end
  end
end
