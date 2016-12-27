Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: "confirmations"
  }
  root "static_pages#home"
  get "contact", to: "static_pages#contact"
  resources :users do
    member do
      get :favorites
      resources :followers, only: :index
      resources :followings, only: :index
      resources :activities, only: :index
    end
  end
  namespace :admin do
    resources :books
    resources :categories
    resources :requests, only: [:index, :update, :show]
    get "", to: "dashboard#home", as: "/"
  end
  resources :books
  resources :favorites, only: [:create, :destroy]
  resources :requests
  resources :categories, only: [:show]
  resources :reviews, except: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :comments, except: :index
  resources :likes, only: [:create, :destroy, :show]
  resources :bookmarks, only: [:create, :update]
end
