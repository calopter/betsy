Rails.application.routes.draw do
  root to: "products#index"
  
  post 'products/:product_id/add', to: 'orders#add', as: 'add_to_cart'
  
  get 'cart', to: 'orders#show', as: 'cart'

  delete 'cart/:id', to: 'order_items#destroy', as: 'remove_from_cart'
  
  get "/auth/github", as: "github_login"

  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"

  resources :users, only: [:show, :register]


  # create a path for Category
  # resources :category

  get "/category/new", to: "category#new", as: "new_category"
  post "/category/new", to: "category#create", as: "categories"
  get "/category/edit", to: "category#edit", as: "edit_category"
  
  get "/login", to: "users#login", as: "login"
  get "/signin", to: "users#signin", as: "signin"
  get "/register", to: "users#register", as: "register"
  delete "/logout", to: "users#destroy", as: "logout"

  get "/dashboard", to: "users#dashboard", as: "dashboard"
  # get "/"


  resources :products
  resources :products do 
    member do 
      post 'review'
    end 
  end
end
