Rails.application.routes.draw do
  root "static_pages#home"
  get "contact", to: "static_pages#contact"
  resources :users do
    member do
      get :favorites
    end
  end
  get "signup" => "users#new"
  post "signup" => "users#create"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  namespace :admin do
    resources :books
    resources :categories
    get "", to: "dashboard#home", as: "/"
  end
  resources :books
  resources :favorites, only: [:create, :destroy]
  resources :requests
  resources :categories, only: [:show]
end
