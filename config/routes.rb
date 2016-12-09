Rails.application.routes.draw do
  root "static_pages#home"
  get "contact", to: "static_pages#contact"
  resources :users
  get "signup" => "users#new"
  post "signup" => "users#create"
end
