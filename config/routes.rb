Storefront::Application.routes.draw do
  devise_for :users

  resources :items
  resources :orders, only: [:create]

  match "/dashboard", to: "dashboard#index"
  match "/profile", to: "profile#index"

  root :to => 'home#index'
end
