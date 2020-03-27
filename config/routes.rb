Rails.application.routes.draw do
  get 'item_pictures/create'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#index'
  resources :geolocs, only: [:index]
  resources :shops
  resources :categories
  resources :carts
  resources :items, only: [:show, :edit, :update, :destroy, :new, :create] do
    resources :picture, only: [:create]
  end

  resources :orders
  resources :makers do
    get 'validate_maker', to: 'makers#validate_maker'
  end

  resources :addresses, only: [:create, :update, :index]

end
