require 'rails_helper'

RSpec.describe 'Albums API' do
  before(:each) do
    @artist1 = create(:artist)
  end

  describe '#Create' do
    it 'can create a new album' do
      album_params = {
        title: 'Born to Run',
        genre: 'Rock',
        release_year: 1975,
        artist_id: @artist1.id
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post api_v1_albums_path, headers: headers, params: JSON.generate(album: album_params)

      created_album = Album.last

      expect(response).to be_successful
      expect(created_album.title).to eq(album_params[:title])
      expect(created_album.genre).to eq(album_params[:genre])
      expect(created_album.release_year).to eq(album_params[:release_year])
    end

    it 'notifies of errors due to missing attributes' do
      album_params = {
        title: 'Born to Run',
        genre: 'Rock'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post api_v1_albums_path, headers: headers, params: JSON.generate(album: album_params)

      expect(response).to_not be_successful
      expect(response.body).to include("Release year can\'t be blank")
    end
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
