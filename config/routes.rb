Rails.application.routes.draw do
  resources :suggestions, only: [:index, :show, :create]
  get "/suggestions/:id/vote", to: "votes#show"
  post "/suggestions/:id/vote", to: "votes#create"
  delete "/suggestions/:id/vote", to: "votes#destroy"
  get "/places/countries-list", to: "places#countries_list"
  resources :places, only: [:index, :show, :create]
  resources :likes
  resources :comments
  put "/users/change-password", to: "users#change_password"
  resources :users, only: [:update, :destroy]
  get "/sessions", to: "sessions#index"
  post "/sessions", to: "sessions#create"
  delete "sessions", to: "sessions#destroy"
  post "/sessions/register", to: "sessions#register"
  get "/_bootstrap_data.js", to: "sessions#bootstrap_js_data"
  get "/_bootstrap_data.js", to: "suggestions#bootstrap_js_data" #new line
  get "/sessions/dump", to: "sessions#dump_session"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
