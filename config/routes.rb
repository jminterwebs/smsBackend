# config/routes.rb
Rails.application.routes.draw do

  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#login'
      post 'signup', to: 'users#create'
      delete 'logout', to: 'authentication#logout'

      resources :users, only: [:create]
      resources :messages
      # Add other protected routes here
    end

  end
end