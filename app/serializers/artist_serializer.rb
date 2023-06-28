class ArtistSerializer
  def self.artists(artists)
    {
      "data": artists.map do |artist|
        {
          "id":         artist[:id],
          "type":       "Artist",
          "attributes": {
            "name": artist[:name],
            "form_year":  artist[:form_year]
          }
        }
      end
    }
  end
end
