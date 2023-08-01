require 'rails_helper'

RSpec.describe 'Albums API' do
  before(:each) do
    @artist1 = create(:artist)
    @user1 = create(:user)

    headers = { "CONTENT_TYPE" => "application/json" }
    post api_v1_login_path(login: { email: @user1.email, password: @user1.password }), headers: headers

    @user_token = response.header['X-AUTH-TOKEN']
    @headers = {
      "CONTENT_TYPE" => "application/json",
      'Authorization': @user_token
    }
  end

  describe '#Create' do
    it 'can create a new album' do
      album_params = {
        title:        'Born to Run',
        genre:        'Rock',
        release_year: 1975,
        image:        'http://image.com',
        api_id:       '123456',
        artist_id: @artist1.id
      }
      post api_v1_albums_path, headers: @headers, params: JSON.generate(album: album_params)

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
      post api_v1_albums_path, headers: @headers, params: JSON.generate(album: album_params)

      expect(response).to_not be_successful
      expect(response.body).to include("Release year can\'t be blank")
    end
  end
end
