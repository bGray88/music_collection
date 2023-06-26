class SongSerializer
  def self.songs(songs)
    {
      "data": songs.map do |song|
        {
          "id":         song[:id],
          "type":       "Song",
          "attributes": {
            "first_name": song[:title],
            "last_name":  song[:create_year],
            "email":      song[:length]
          }
        }
      end
    }
  end
end
