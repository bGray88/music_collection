class AlbumSerializer
  def self.albums(albums)
    {
      "data": albums.map do |album|
        {
          "id":         album[:id],
          "type":       "Album",
          "attributes": {
            "title": album[:title],
            "release_year":  album[:release_year],
            "genre":      album[:genre]
          }
        }
      end
    }
  end
end
