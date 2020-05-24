Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :users
  resources :credits
  resources :products do
    resources :purchases
  end
  resources :brands
  resources :categories
  resources :addresses
end
