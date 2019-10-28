Rails.application.routes.draw do
  root "products#index"
  
  get "/auth/github", as: "github_login"

  get "/auth/:provider/callback", to: "users#create"

  resources :users, only: [:show, :register]

  get "/login", to: "users#login", as: "login"
  get "/signin", to: "users#signin", as: "signin"
  get "/register", to: "users#register", as: "register"
  delete "/logout", to: "users#destroy", as: "logout"

  resources :products
  resources :products do 
    member do 
      post 'review'
    end 
  end
end
