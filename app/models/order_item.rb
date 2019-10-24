class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
end
# app/models/order_item.rb
# /Users/gutierrez/Ada/betsy/app/models/order_item.rb