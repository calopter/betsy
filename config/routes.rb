Rails.application.routes.draw do
  
  resources :orders
  
  post "/orders/:id/complete_purchase", to: "orders#complete_purchase", as: "complete_purchase"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
