require 'rails_helper'

RSpec.describe 'Albums API' do
  before(:each) do
    @headers = {
      "CONTENT_TYPE" => "application/json",
    }
  end

  describe '#Show' do
    it 'can retrieve search results in expected format' do
      data = {
        "find_album_id": "4aawyAB9vmqN3uQ7FjRGTy"
      }
      get api_v1_album_path, headers: @headers, params: data

      album = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(album).to have_key(:id)
      expect(album).to have_key(:type)
      expect(album).to have_key(:attributes)

      album_attr = album[:attributes]

      expect(album_attr).to have_key(:title)
      expect(album_attr).to have_key(:release_year)
      expect(album_attr).to have_key(:genres)
      expect(album_attr).to have_key(:image)
      expect(album_attr).to have_key(:api_id)
      expect(album_attr).to have_key(:artist_id)
    end
  end
end