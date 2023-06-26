class AlbumSerializer
  def self.albums(albums)
    {
      "data": albums.map do |album|
        {
          "id":         album[:id],
          "type":       "Album",
          "attributes": {
            "first_name": album[:title],
            "last_name":  album[:release_year],
            "email":      album[:genre]
          }
        }
      end
    }
  end
end
