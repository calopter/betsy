class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  
  def self.formatter(integer)
    integer = integer.to_s
    integer.delete! "."
    
    cents = integer[-2..-1]
    dollars = integer[0..-3]
    return_statement = "#{dollars}.#{cents}"
  end
  
  def self.price(id)
    order_items = OrderItem.where(order_id: id)
    
    total_order_price = 0
    
    order_items.each do |order_item|
      item_subtotal = order_item.quantity * Product.find(order_item.product_id).price
      
      total_order_price += item_subtotal
    end
    
    total_order_price *= 1.10
    
    formatted_total_order_price= formatter(total_order_price)
    
    return formatted_total_order_price
    
  end
  
  

  
  
  # validates :status, presence: true
  # validates :status, inclusion: { in: ["pending", "paid", "complete", "cancelled"] }
  
  # def related_user_cc_expiration
  #   @login_user = User.find_by(id: "blarg")
  #   if @login_user != nil
  #     if @login_user.cc_expiration == "1121"
  #       errors.add(:cc_expiration, "The user cc expiration must exist")
  #     end
  #   end
  # end
  # validate :related_user_cc_expiration
  
  
  

  def revenue
    order_items.map(&:total).sum
  end
end
