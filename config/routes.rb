Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :users
  resources :credits
  resources :products
  resources :brands
  resources :categories
  resources :purchase
  resources :addresses
end
