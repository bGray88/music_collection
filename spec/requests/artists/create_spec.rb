require 'rails_helper'

RSpec.describe 'Artists API' do
  describe '#Create' do
    it 'can create a new album' do
      artist_params = {
        name: 'The Churchills',
        form_year: 1975
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post api_v1_artists_path, headers: headers, params: JSON.generate(artist: artist_params)

      created_artist = JSON.parse(response.body, symbolize_names: true).dig(:artists, :data, 0)

      expect(response).to be_successful
      expect(created_artist.dig(:attributes, :name)).to eq(artist_params[:name])
      expect(created_artist.dig(:attributes, :form_year)).to eq(artist_params[:form_year])
    end

    it 'notifies of errors due to missing attributes' do
      artist_params = {
        name: 'Winchell McNuggets',
        genre: 'Rock'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post api_v1_artists_path, headers: headers, params: JSON.generate(artist: artist_params)

      expect(response).to_not be_successful
      expect(response.body).to include("Form year can\'t be blank")
    end
  end
end
