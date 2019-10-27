Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"


  get "/auth/github", as: "github_login"

  get "/auth/:provider/callback", to: "users#create"

  # resources :users
  # post "/users/:id/login", to: "users#login", as: "login"

  resources :users, only: [:show, :register]

  get "/login", to: "users#login", as: "login"
  get "/signin", to: "users#signin", as: "signin"
  get "/register", to: "users#register", as: "register"
  delete "/logout", to: "users#destroy", as: "logout"

end
