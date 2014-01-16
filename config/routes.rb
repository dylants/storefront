Storefront::Application.routes.draw do
  devise_for :users

  resources :items
  resources :orders, only: [:create]

  get "/dashboard", to: "dashboard#index"

  root :to => 'home#index'
end
