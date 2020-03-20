Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#index'

  resources :shops
  resources :categories
  resources :carts
  resources :items, only: [:show]
  resources :orders

  resources :addresses, only: [:create, :update]

end
