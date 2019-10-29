class OrdersController < ApplicationController
  def show
    @order = Order.find_by(id: get_cart[:order_id])
    session[:order_id] = @order.id
  end
  
  def add
    order = get_cart
    order_item = OrderItem.new(order_item_params.merge(order).merge(product_id))
    
    if order_item.save
      session[:order_id] = order[:order_id]
      flash[:success] = "Added #{ order_item.quantity } #{ order_item.product.name } to cart"
    else
      flash[:error] = "unable to add to cart"
      flash[:messages] = order_item.errors.messages
    end
    redirect_to cart_path
  end

  private

  
  def order_item_params
    params.require(:order_item).permit(:quantity).merge({ shipping_status: "pending" })
  end

  def product_id
    { product_id: params.require(:product_id) }
  end
end
