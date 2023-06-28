Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/register',  to: 'users#new'
      resources :users, only: [:create]
      get '/dashboard', to: 'users#show', as: 'user'
      resources :albums, only: [:index, :create]
      resources :login, only: [:create, :destroy]
    end
  end
end
