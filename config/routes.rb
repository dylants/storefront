Storefront::Application.routes.draw do
  devise_for :users

  resources :items

  root :to => 'home#index'
end
