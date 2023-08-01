class UserAlbumFacade
  def self.user_albums(albums)
    albums.map do |album|
      album  = Album.find(album[:album_id])
      artist = Artist.find(album[:artist_id])
      AlbumPoro.new(album_props(album, artist))
    end
  end

  def self.album_props(album, artist)
    {
      id:           album[:api_id],
      name:         album[:title],
      release_date: album[:release_year].to_s,
      genres:       [album[:genre]],
      images:       [{ url: album[:image] }],
      api_id:       album[:api_id],
      artists:      [{ id: artist[:api_id] }]
    }
  end
end
