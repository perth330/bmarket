Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :users
  resources :credits
  resources :products do
    resources :purchase
  end
  resources :brands
  resources :categories
  resources :purchase
  resources :addresses
end
