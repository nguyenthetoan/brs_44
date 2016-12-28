Rails.application.routes.draw do

  devise_for :users, controllers: {confirmations: "confirmations"}

  as :user do
    get "/login" => "devise/sessions#new", as: :login
    post "/login" => "devise/sessions#create"
    delete "/logout" => "devise/sessions#destroy", as: :logout
    get "/signup" => "devise/registrations#new", as: :signup
    post "/signup" => "devise/registrations#create"
  end

  resources :users do
    member do
      get :favorites
      resources :followers, only: :index
      resources :followings, only: :index
      resources :activities, only: :index
    end
  end
  root "static_pages#home"
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
