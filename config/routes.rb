Rails.application.routes.draw do
  resources :suggestions
  resources :places
  resources :likes
  resources :comments
  resources :votes
  resource :users, only: [:update, :destroy]
  get "/sessions", to: "sessions#index"
  post "/sessions", to: "sessions#create"
  delete "sessions", to: "sessions#destroy"
  post "/sessions/register", to: "sessions#register"
  get "/_bootstrap_data.js", to: "sessions#bootstrap_js_data"
  get "/sessions/dump", to: "sessions#dump_session"
  put "/users/change-password", to: "users#change_password"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
