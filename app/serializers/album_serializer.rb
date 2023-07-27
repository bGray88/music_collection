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
            "image":         album[:images][2]
          }
        }
      end
    }
  end
end
