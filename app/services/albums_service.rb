class AlbumsService
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

  def self.search_by_artist(name, token, limit = 10, market = "US")
    response = {}
    data = {
      "q": "artist=#{name}",
      "type": "album",
      "limit": limit,
      "market": market
    }
    headers = {
      "Authorization": "Bearer #{token}",
      "Content-Type": "application/x-www-form-urlencoded"
    }
    unless response[name]
      response[name] = conn.get("/v1/search?", data, headers)
    end
    parse_json(response[name])
  end

  def self.search_by_album_id(album_id, token, limit = 10, market = "US")
    response = {}
    headers = {
      "Authorization": "Bearer #{token}",
      "Content-Type": "application/x-www-form-urlencoded"
    }
    unless response[album_id]
      response[album_id] = conn.get("/v1/albums/#{album_id}", data={}, headers)
    end
    parse_json(response[album_id])
  end

  def self.search_suggested(seed, token, limit = 10, market = "US")
    data = {
      "seed_genres": seed,
      "type": "album",
      "limit": limit,
      "market": market
    }
    headers = {
      "Authorization": "Bearer #{token}",
      "Content-Type": "application/x-www-form-urlencoded"
    }
    response ||= conn.get("/v1/recommendations?", data, headers)
    parse_json(response)
  end

  def self.search_recent(token, limit = 10, market = "US")
    data = {
      "limit": limit,
      "country": market
    }
    headers = {
      "Authorization": "Bearer #{token}",
      "Content-Type": "application/x-www-form-urlencoded"
    }
    response ||= conn.get("/v1/browse/new-releases?", data, headers)
    parse_json(response)
  end
end
