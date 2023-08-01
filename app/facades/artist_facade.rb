class ArtistFacade
  def self.artists(artists)
    artists.map do |artist|
      ArtistPoro.new(artist_props(artist))
    end
  end

  def self.artist_props(artist)
    {
      id:     artist[:id],
      name:   artist[:name],
      images: artist[:images],
      api_id: artist[:id]
    }
  end
end
