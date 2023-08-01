require 'rails_helper'

RSpec.describe 'Artists API' do
  before(:each) do
    @headers = {
      "CONTENT_TYPE" => "application/json",
    }
  end

  describe '#Show' do
    it 'can retrieve search results in expected format' do
      data = {
        "find_artist_id": "0TnOYISbd1XYRBk9myaseg"
      }
      get api_v1_artist_path, headers: @headers, params: data

      artist = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(artist).to have_key(:id)
      expect(artist).to have_key(:type)
      expect(artist).to have_key(:attributes)

      artist_attr = artist[:attributes]

      expect(artist_attr).to have_key(:name)
      expect(artist_attr).to have_key(:image)
      expect(artist_attr).to have_key(:api_id)
    end
  end
end