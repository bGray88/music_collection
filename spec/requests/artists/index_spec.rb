require 'rails_helper'

RSpec.describe 'Artists API' do
  describe '#Index' do
    before(:each) do
      @artists = create_list(:artist, 5)
      @artist1 = @artists.first
    end

    it 'can list all artists' do
      headers = { "CONTENT_TYPE" => "application/json" }
      get api_v1_artists_path, headers: headers

      expect(response).to be_successful

      artists = JSON.parse(response.body, symbolize_names: true)

      expect(artists[:data].length).to eq(5)

      artist1 = artists.dig(:data, 0)

      expect(artist1[:id]).to eq(@artist1[:id])
      expect(artist1.dig(:attributes, :name)).to eq(@artist1[:name])
      expect(artist1.dig(:attributes, :image)).to eq(@artist1[:image])
      expect(artist1.dig(:attributes, :api_id)).to eq(@artist1[:api_id])
    end
  end
end
