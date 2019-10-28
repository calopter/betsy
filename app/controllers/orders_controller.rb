class OrdersController < ApplicationController
  
  def complete_purchase
    find_order
    find_user
    #changes order's status to "paid"
    
    #adjusts the stock for associated products
    @order_items = OrderItem.where(order_id: @current_order.id)
    
    @order_items.each do |order_item|
      product = Product.find_by(id: order_item.product_id)
      adjusting_quantity = order_item.quantity
      product.stock -= adjusting_quantity
      product.save
    end
    
    @order_price = Order.price(@current_order.id)
    
    @current_order.date_time_order_purchased = DateTime.now
    
    @current_order.save
    
  end
  
  def show
    if @current_order == nil
      redirect_to root_path
    else
      @items = OrderItem.where(order_id: @current_order.id)
    end
  end
  
  def main
  end
  
  private
  
  def find_order
    @current_order = Order.find_by(id: params[:id])
  end
  
  def find_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  
  
end