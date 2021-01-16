Rails.application.routes.draw do
  resources :suggestions
  resources :places
  resources :likes
  resources :comments
  resources :votes
  resources :users, only: [:update, :destroy]
  resources :sessions, only: [:create, :index, :destroy]
  put "/users/:id/change-password", to: "users#change_password"
  post "/sessions/register", to: "sessions#register"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
