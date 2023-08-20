class AlbumFacade
  def self.albums(albums, user_id)
    albums.map do |album|
      album_id = Album.find_by(api_id: album[:id])
      owned = UserAlbum.find_by(user_id: user_id, album_id: album_id).present?
      AlbumPoro.new(album_props(album, owned))
    end
  end

  def self.albums_tracks(albums, user_id)
    albums.map do |album|
      album = album[:album]
      owned = UserAlbum.find_by(user_id: user_id, album_id: album[:id]).present?
      AlbumPoro.new(album_props(album, owned))
    end
  end

  def self.album_props(album, owned)
    {
      id:           album[:id],
      name:         album[:name],
      release_date: album[:release_date],
      genres:       album[:genres],
      images:       album[:images],
      api_id:       album[:id],
      artists:      album[:artists],
      owned:        owned
    }
  end
end
