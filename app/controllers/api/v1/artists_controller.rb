class Api::V1::ArtistsController < ApplicationController
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

  private

  def artist_params
    params.require(:artist).permit(
      :name,
      :form_year
    )
  end
end
