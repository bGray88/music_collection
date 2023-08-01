class ArtistSerializer
  def self.artists(artists)
    {
      "data": artists.map do |artist|
        {
          "id":   artist.id,
          "type": "Artist",
          "attributes": {
            "name":      artist.name,
            "image":     artist.image,
            "api_id":    artist.api_id
          }
        }
      end
    }
  end
end
