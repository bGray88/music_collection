require 'rails_helper'

RSpec.describe 'Albums Service' do
  describe "Search" do
    it 'search various types on Spotify through API' do
      session_token ||= AlbumsService.renew_auth_token[:access_token]
      search_response = AlbumsService.search_by_artist("Led Zeppilin", session_token)

      expect(search_response).to have_key(:albums)
      expect(search_response[:albums]).to have_key(:items)
      expect(search_response.dig(:albums, :items).length).to be > (1)
    end
  end
end
