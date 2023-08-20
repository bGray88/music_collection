class Api::V1::AlbumsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def create
    artist = Artist.find_by(api_id: album_params[:artist_id])
    params[:album][:artist_id] = artist.id
    album = Album.new(album_params)
    if album.save
      render json: { "success": "Album added successfully" }, status: :created
    else
      render json: { "errors": album.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def index
    update_token
    if params[:search]
      render json: AlbumSerializer.albums(
        AlbumFacade.albums(
          AlbumsService.search_by_artist(
            params[:search],
            session[:token]
          )[:albums][:items],
          current_user&.id
        )
      )
    end
    if params[:suggest]
      render json: AlbumSerializer.albums_slides(
        AlbumFacade.albums_tracks(
          AlbumsService.search_suggested(
            ['classic', 'rock', 'punk'].sample,
            session[:token]
          )[:tracks],
          current_user&.id
        )
      )
    end
    if params[:recent]
      render json: AlbumSerializer.albums_slides(
        AlbumFacade.albums(
          AlbumsService.search_recent(
            session[:token]
          )[:albums][:items],
          current_user&.id
        )
      )
    end
  end

  def show
    update_token
    render json: AlbumSerializer.albums(
      AlbumFacade.albums(
        [AlbumsService.search_by_album_id(
          params[:find_album_id],
          session[:token]
        )],
        current_user&.id
      )
    )
  end

  private

  def album_params
    params.require(:album).permit(
      :title,
      :genre,
      :release_year,
      :image,
      :api_id,
      :artist_id
    )
  end
end
