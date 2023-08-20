class AlbumPoro
  attr_reader :id,
              :title,
              :release_year,
              :genres,
              :image,
              :api_id,
              :artist_id,
              :owned

  def initialize(album)
    @id           = album[:id]
    @title        = album[:name]
    @release_year = album[:release_date][0..3].to_s
    @genres       = album[:genres]
    @image        = album[:images][0][:url]
    @api_id       = album[:api_id]
    @artist_id    = album[:artists][0][:id]
    @owned        = album[:owned]
  end
end
