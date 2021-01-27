Rails.application.routes.draw do
  get "/suggestions/upvoted", to: "suggestions#upvoted"
  resources :suggestions, only: [:index, :show, :create]
  get "/suggestions/:id/vote", to: "votes#show"
  post "/suggestions/:id/vote", to: "votes#create"
  get "/suggestions/:id/get_votes", to: "suggestions#get_votes"
  delete "/suggestions/:id/vote", to: "votes#destroy"
  get "/places/countries-list", to: "places#countries_list"
  resources :places, only: [:index, :create]
  put "/users/change-password", to: "users#change_password"
  delete "/users", to: "users#destroy"
  resources :users, only: [:update]
  get "/sessions", to: "sessions#index"
  post "/sessions", to: "sessions#create"
  delete "sessions", to: "sessions#destroy"
  post "/sessions/register", to: "sessions#register"
  get "/_bootstrap_data.js", to: "sessions#bootstrap_js_data"
  get "/sessions/dump", to: "sessions#dump_session"
end
