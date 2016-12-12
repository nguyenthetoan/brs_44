Rails.application.routes.draw do
  root "static_pages#home"
  get "contact", to: "static_pages#contact"
  resources :users do
    resources :books, except: [:create, :destroy]
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
end
