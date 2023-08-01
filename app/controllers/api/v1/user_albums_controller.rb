class Api::V1::UserAlbumsController < ApplicationController
  def create
    album = Album.find_by(api_id: params[:album_id])
    user_album = UserAlbum.new(user_id: @_current_user.id, album_id: album.id)
    if user_album.save
      render json: { "success": "Album added to User successfully" }, status: :created
    else
      render json: {
        "errors": user_album.errors.full_messages.to_sentence
      }, status: :bad_request
    end
  end

  def index
    user_albums = UserAlbum.where(user_id: @_current_user.id)
    if user_albums
      render json: AlbumSerializer.albums(
        UserAlbumFacade.user_albums(user_albums)
      )
    else
      render json: { "data": [] }
    end
  end

  def destroy
    user_album = UserAlbum.find_by(user_id: @_current_user.id, album_id: params[:album_id])
    if user_album&.delete
      render json: { "success": "Album removed from User successfully" }, status: :ok
    else
      render json: {
        "errors": user_album.errors.full_messages.to_sentence
      }, status: :bad_request
    end
  end
end
