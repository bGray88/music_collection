Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      get '/dashboard', to: 'users#show', as: 'user'
    end
  end
end
