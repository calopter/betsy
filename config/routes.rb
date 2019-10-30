Rails.application.routes.draw do 
  root to: "products#index"
  
  get "/orders/:id/complete_purchase", to: "orders#complete_purchase", as: "complete_purchase"
  
  post "/orders/:id/complete_purchase", to: "orders#purchase_confirmation", as: "orders_purchase_confirmation"
  
  post 'products/:product_id/add', to: 'orders#add', as: 'add_to_cart'
  
  get 'cart', to: 'orders#show', as: 'cart'

  patch 'cart/:id', to: 'order_items#update', as: 'update_cart'
  
  delete 'cart/:id', to: 'order_items#destroy', as: 'remove_from_cart'
  
  get "/auth/github", as: "github_login"

  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"

  resources :category
  # create a path for Category
  # resources :category
  # get "/category/new", to: "category#new", as: "new_category"
  post "/category/new", to: "category#create", as: "categories"
  # get "/category/edit", to: "category#edit", as: "edit_category"
  
  resources :users, only: [:show, :register, :edit, :update]
  
  get "/login", to: "users#login", as: "login"
  get "/signin", to: "users#signin", as: "signin"
  get "/register", to: "users#register", as: "register"
  delete "/logout", to: "users#destroy", as: "logout"

  get "/dashboard", to: "users#dashboard", as: "dashboard"

  resources :orders
  resources :products do 
    member do 
      #have reviews controller 
      # resource :reviews, only: [:new, csreate]
      post 'review'
    end 
  end
end
