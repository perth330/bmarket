Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :users
  resources :credits
  resources :products do
    resources :purchases
    resources :favorites, only: [:create, :destroy]
  end
  resources :brands
  resources :categories
  resources :addresses
end
