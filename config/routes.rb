Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end

      resources :vendors, only: [:show, :create, :update, :destroy] do
        resources :markets, only: [:index], controller: "vendors/markets"
      end

      resources :market_vendors, only: [:create]
      delete "/market_vendors", to: "market_vendors#destroy"
    end
  end
end
