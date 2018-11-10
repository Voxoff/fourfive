Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'education', to: 'pages#education'
  get 'privacy_policy', to: 'pages#privacy_policy'

  resources :products, only: [:show, :index]
  resources :cart_items, only: [:show, :create, :index] do
  end
  # resources :users, only: :show do
    resources :carts, only: [:show] do
      resources :payments, only: [:new, :create]
    end
  # end
  resources :reviews, only: :index
end
