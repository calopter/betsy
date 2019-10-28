class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews
  
  validates :email, presence: true, on: :completing_purchase
  
  def order_count
    orders.group_by(&:status).transform_values(&:count)
  end
  
  def revenue
    orders.map(&:revenue).sum
  end
  
  def revenues
    orders.group_by(&:status).transform_values do |orders|
      orders.map(&:revenue).sum
    end
  end
end
