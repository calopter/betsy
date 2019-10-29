Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "products#index"
  
  get "/orders/:id/complete_purchase", to: "orders#complete_purchase", as: "complete_purchase"
  
  post "/orders/:id/complete_purchase", to: "orders#purchase_confirmation", as: "orders_purchase_confirmation"
  
  post 'products/:product_id/add', to: 'orders#add', as: 'add_to_cart'
  
  get 'cart', to: 'orders#show', as: 'cart'
  
  delete 'cart/:id', to: 'order_items#destroy', as: 'remove_from_cart'
  
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
