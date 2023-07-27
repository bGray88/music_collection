class Api::V1::AlbumsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  def create
    album = Album.new(album_params)
    if album.save
      render json: { "success": "Album added successfully" }, status: :created
    else
      render json: { "errors": album.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def index
    session[:token] ||= AlbumsService.renew_auth_token[:access_token]
    session[:token_type] ||= AlbumsService.renew_auth_token[:token_type]
    session[:expires_in] ||= AlbumsService.renew_auth_token[:expires_in]
    render json: AlbumSerializer.albums(AlbumsService.search_by_artist(params[:search], session[:token]))
  end

  private

  def album_params
    params.require(:album).permit(
      :title,
      :genre,
      :release_year,
      :artist_id
    )
  end
end
