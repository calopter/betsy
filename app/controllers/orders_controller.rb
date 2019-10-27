class OrdersController < ApplicationController
  def add
    order = get_cart
    order_item = OrderItem.new(order_item_params.merge(order)
                                    .merge(product_id))
    if order_item.save
      session[:order_id] = order[:order_id]
      flash[:success] = "Added #{ order_item.quantity } #{ order_item.product.name } to cart"
    else
      flash[:error] = "unable to add to cart"
      flash[:messages] = order_item.errors.messages
    end
    redirect_to cart_path(order)
  end

  private
  def get_cart
    id = session[:order_id]
    
    if id
      return { order_id: id }
    else
      user = User.create
      return { order_id: Order.create(user: user, status: "pending").id }
    end
  end
  
  def order_item_params
    params.require(:order_item).permit(:quantity).merge({ shipping_status: "pending" })
  end

  def product_id
    { product_id: params.require(:product_id) }
  end
end
