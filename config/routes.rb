Rails.application.routes.draw do 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "orders#main"
  
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  get "/orders/:id/see_order", to: "orders#show", as: "show"
  
  get "/orders/:id/complete_purchase", to: "orders#complete_purchase", as: "complete_purchase"
  post "/orders/:id/complete_purchase", to: "orders#purchase_confirmation", as: "orders_purchase_confirmation"
  
  
  resources :orders
  resources :users
  resources :products
  
end
