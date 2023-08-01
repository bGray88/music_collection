class AlbumFacade
  def self.albums(albums)
    albums.map do |album|
      AlbumPoro.new(album_props(album))
    end
  end

  def self.albums_tracks(albums)
    albums.map do |album|
      album = album[:album]
      AlbumPoro.new(album_props(album))
    end
  end

  def self.album_props(album)
    {
      id:           album[:id],
      name:         album[:name],
      release_date: album[:release_date],
      genres:       album[:genres],
      images:       album[:images],
      api_id:       album[:id],
      artists:      album[:artists]
    }
  end
end
