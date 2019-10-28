class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def revenue
    order_items.map(&:total).sum
  end
end
