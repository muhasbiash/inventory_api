Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      post "/login",    to: "auth#login"
      post "/register", to: "auth#register"

      get "/dashboard", to: "dashboard#index"

      resources :products do
        member do
          get :qrcode
        end
      end

      resources :categories
      resources :warehouses
      resources :stock_movements
      resources :notifications

    end
  end
end