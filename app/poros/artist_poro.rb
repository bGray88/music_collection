class ArtistPoro
  attr_reader :id,
              :name,
              :image,
              :api_id

  def initialize(artist)
    @id     = artist[:id]
    @name   = artist[:name]
    @image  = artist[:images][0][:url]
    @api_id = artist[:api_id]
  end
end
