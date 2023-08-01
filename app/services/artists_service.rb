class ArtistsService
  def self.auth_conn
    Faraday.new(url: 'https://accounts.spotify.com') do |req|
      req.request :url_encoded
      req.adapter :net_http
    end
  end

  def self.conn
    Faraday.new(url: 'https://api.spotify.com') do |req|
      req.request :url_encoded
      req.adapter :net_http
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.renew_auth_token
    data = {
      "grant_type":    "client_credentials",
      "client_id":     "#{ENV["SPOTIFY_CLIENT_ID"]}",
      "client_secret": "#{ENV["SPOTIFY_CLIENT_SC"]}"
    }
    headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    }
    response = auth_conn.post('/api/token', data, headers)
    parse_json(response)
  end

  def self.search_by_artist_id(artist_id, token, limit = 10, market = "US")
    response = {}
    headers = {
      "Authorization": "Bearer #{token}",
      "Content-Type": "application/x-www-form-urlencoded"
    }
    unless response[artist_id]
      response[artist_id] = conn.get("/v1/artists/#{artist_id}", data={}, headers)
    end
    parse_json(response[artist_id])
  end
end
