class AlbumSerializer
  def self.albums(albums)
    {
      "data": albums.map do |album|
        {
          "id":         album.id,
          "type":       "Album",
          "attributes": {
            "title":        album.title,
            "release_year": album.release_year,
            "genres":       album.genres,
            "image":        album.image,
            "api_id":       album.api_id,
            "artist_id":    album.artist_id,
            "owned":        album.owned
          }
        }
      end
    }
  end

  def self.albums_slides(albums)
    {
      "data": albums.map do |album|
        {
          "introline": album.title,
          "id":        album.id,
          "type":      "Album",
          "content": {
            "title":        album.title,
            "release_year": album.release_year,
            "genres":       album.genres,
            "image":        album.image,
            "api_id":       album.api_id,
            "artist_id":    album.artist_id,
            "owned":        album.owned
          }
        }
      end
    }
  end
end
