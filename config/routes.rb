Rails.application.routes.draw do
  resources :suggestions
  resources :places
  resources :likes
  resources :comments
  resources :votes
  resources :users, only: [:create]
  resources :sessions, only: [:create, :index, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
