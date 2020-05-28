Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    }
  devise_scope :user do
    get "registrations_address", to: "users/registrations#new_address"
    post "registrations_address", to: "users/registrations#create_address"
  end
  root "products#index"
  resources :users , only: [:index, :show]
  resources :credits, only: [:new, :create, :show, :destroy]
  resources :products do
    resources :purchases, only: [:new, :create, :show]
    resources :comments, only: [:create]
    collection do
      get 'search'
    end
  end
  resources :favorites, only: [:index, :create, :destroy]
  resources :brands, only: [:index, :new]
  resources :categories, only: [:new]
  resources :addresses, only: [:index, :new, :create, :destroy]
  resources :infomations, only: [:index, :show]
end
