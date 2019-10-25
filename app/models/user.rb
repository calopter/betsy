class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews

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
