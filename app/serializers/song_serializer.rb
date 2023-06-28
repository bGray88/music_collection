class SongSerializer
  def self.songs(songs)
    {
      "data": songs.map do |song|
        {
          "id":         song[:id],
          "type":       "Song",
          "attributes": {
            "title": song[:title],
            "create_year":  song[:create_year],
            "length":      song[:length]
          }
        }
      end
    }
  end
end
