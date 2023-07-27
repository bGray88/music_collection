module SpotifyWebToken
  extend ActiveSupport::Concern

  def update_token
    if !session[:expires_at] || session[:expires_at] < Time.now
      auth_data            = AlbumsService.renew_auth_token
      session[:token]      = auth_data[:access_token]
      session[:token_type] = auth_data[:token_type]
      session[:expires_at] = Time.at(Time.now + auth_data[:expires_in].seconds)
    end
  end
end
