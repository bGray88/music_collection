class AlbumSerializer
  def self.albums(albums)
    {
      "data": albums.dig(:albums, :items).map do |album|
        {
          "id":         album[:id],
          "type":       "Album",
          "attributes": {
            "title":         album[:name],
            "release_year":  album[:release_date][0..3].to_i,
            "genres":        album[:genres],
            "image":         album.dig(:images, 0, :url)
          }
        }
      end
    }
  end

  def self.album_slides_tracks(albums)
    {
      "data": albums.dig(:tracks).map do |album|
        {
          "introline": album.dig(:album, :name),
          "id":        album.dig(:album, :id),
          "type":      "Album",
          "content": {
            "title":        album.dig(:album, :name),
            "release_year": album.dig(:album, :release_date),
            "genres":       album.dig(:album, :genres),
            "image":        album.dig(:album, :images, 0, :url)
          }
        }
      end
    }
  end

  def self.album_slides_albums(albums)
    {
      "data": albums.dig(:albums, :items).map do |album|
        {
          "introline": album[:name],
          "id":        album[:id],
          "type":      "Album",
          "content": {
            "title":         album[:name],
            "release_year":  album[:release_date][0..3].to_i,
            "genres":        album[:genres],
            "image":         album.dig(:images, 0, :url)
          }
        }
      end
    }
  end
end
