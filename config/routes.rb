Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#index'

  resources :shops
  resources :categories
  resources :carts
  resources :items, only: [:show, :edit, :update, :destroy, :new, :create]
  resources :orders
  resources :makers do
    post 'new_maker_email'
  end

  resources :addresses, only: [:create, :update]

end
