# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#login'
      post 'signup', to: 'users#create'
      delete 'logout', to: 'authentication#logout'

      resources :users, only: [:create]
      # Add other protected routes here
    end

  end
end