class AlbumFacade
  def self.albums(albums)
    {
      albums: {
        items: albums.map do |album|
          {
            id: album.id,
            name: album.title,
            release_date: album.release_year.to_s,
            genres: album.genre,
            images: [{ url: album.image }] 
          }
        end
      }
    }
  end
end
