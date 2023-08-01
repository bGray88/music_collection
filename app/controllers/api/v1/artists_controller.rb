class Api::V1::ArtistsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def create
    artist = Artist.new(artist_params)
    if artist.save
      render json: {
         "success": "Artist added successfully",
         "artists": ArtistSerializer.artists([artist])
      }, status: :created
    else
      render json: { "errors": artist.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def index
    render json: ArtistSerializer.artists(Artist.all)
  end

  def show
    update_token
    if params[:find_artist_id]
      render json: ArtistSerializer.artists(
        ArtistFacade.artists(
          [ArtistsService.search_by_artist_id(
            params[:find_artist_id],
            session[:token]
          )]
        )
      )
    end
  end

  private

  def artist_params
    params.require(:artist).permit(
      :name,
      :image,
      :api_id
    )
  end
end
