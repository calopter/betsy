Rails.application.routes.draw do
  post 'products/:product_id/add', to: 'orders#add', as: 'add_to_cart'
  get 'cart/:order_id', to: 'orders#show', as: 'cart'
end
