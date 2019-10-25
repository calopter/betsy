Rails.application.routes.draw do
  post 'products/:id/add', to: 'order#add', as: 'add_to_cart'
end
