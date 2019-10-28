Rails.application.routes.draw do
  post 'products/:product_id/add', to: 'orders#add', as: 'add_to_cart'
  
  get 'cart', to: 'orders#show', as: 'cart'

  delete 'cart/:id', to: 'order_items#destroy', as: 'remove_from_cart'
end
