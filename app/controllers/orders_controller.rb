class OrdersController < ApplicationController
  
  before_action :find_order, only: [:index, :show]
  
  
  def new
    new_order = Order.new
  end
  
  def create
    if @current_order == nil
      new_order = Order.create
    end
  end
  
  def complete_purchase
    #changes order's status to "paid"
    
    #adjusts the stock for associated products
    order_items = OrderItem.where(order_id = @current_order.id)
    order_items each do |order_item|
      product = Product.find_by(id: product_id)
      adjusting_quantity = order_item.quantity
      product.stock -= adjusting_quantity
      product.save
    end
    
  end
  
  def show
    # raise
    @items = OrderItem.where(order_id = @current_order_id.id)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order.user_id)
  end
  
  def find_order
    @current_order = Order.find_by(id: session[:order_id])
  end
  
  def find_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
end