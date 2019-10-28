Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "products#index"
  
  get "/orders/:id/complete_purchase", to: "orders#complete_purchase", as: "complete_purchase"
  post "/orders/:id/complete_purchase", to: "orders#purchase_confirmation", as: "orders_purchase_confirmation"
  
  get "/auth/github", as: "github_login"
  
  get "/auth/:provider/callback", to: "users#create"
  
  resources :users, only: [:show, :register]
  
  get "/login", to: "users#login", as: "login"
  get "/signin", to: "users#signin", as: "signin"
  get "/register", to: "users#register", as: "register"
  delete "/logout", to: "users#destroy", as: "logout"
  
  resources :orders
  resources :products
  resources :products do 
    member do 
      post 'review'
    end 
  end
end
