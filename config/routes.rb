Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/register',  to: 'users#create'
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/dashboard', to: 'users#show', as: 'user'
      resources :artists, only: [:create, :index]
      resources :albums, only: [:create, :index]
    end
  end
end
