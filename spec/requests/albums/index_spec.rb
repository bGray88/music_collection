require 'rails_helper'

RSpec.describe 'Albums API' do
  before(:each) do
    @artist1 = create(:artist)
  end

  describe '#Index' do
    before(:each) do
      @artist1 = create(:artist)
      @album1  = create(:album, artist: @artist1)
      @album2  = create(:album, artist: @artist1)
      @album3  = create(:album, artist: @artist1)
    end

    it 'can list all albums' do
      headers = { "CONTENT_TYPE" => "application/json" }
      get api_v1_albums_path, headers: headers

      expect(response).to be_successful

      albums = JSON.parse(response.body, symbolize_names: true)

      expect(albums[:data].length).to eq(3)

      album1 = albums.dig(:data, 0)

      expect(album1.dig(:attributes, :title)).to eq(@album1[:title])
      expect(album1.dig(:attributes, :genre)).to eq(@album1[:genre])
      expect(album1.dig(:attributes, :release_year)).to eq(@album1[:release_year])
    end
  end
end
