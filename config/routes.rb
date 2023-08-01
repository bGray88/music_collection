Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/register',  to: 'users#create'
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/dashboard', to: 'users#show', as: 'user'
      get '/album', to: 'albums#show', as: 'album'
      get '/artist', to: 'artists#show', as: 'artist'
      resources :artists, only: [:create, :index]
      resources :albums, only: [:create, :index]
      post '/user_albums', to: 'user_albums#create'
      get '/user_albums', to: 'user_albums#index'
      delete '/user_albums', to: 'user_albums#destroy'
    end
  end
end
