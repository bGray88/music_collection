class ArtistSerializer
  def self.artists(artists)
    {
      "data": artists.map do |artist|
        {
          "id":         artist[:id],
          "type":       "Artist",
          "attributes": {
            "first_name": artist[:name],
            "last_name":  artist[:form_year]
          }
        }
      end
    }
  end
end
