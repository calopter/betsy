class OrdersController < ApplicationController
  
  before_action :find_user, only:[:complete_purchase, :purchase_confirmation]
  before_action :find_cart, only:[:complete_purchase, :purchase_confirmation]
  
  def complete_purchase
    
    if @cart.order_items.count == 0
      redirect_to root_path
      return
    end
    
    if !@cart.user.valid?
      redirect_to root_path
      return
    end
    
    # @order_price = Order.price(@current_order.id)
    
    purchase_confirmation
  end
  
  def purchase_confirmation
    
    @cart.status = "paid"
    
    @cart.date_time_order_purchased = DateTime.now
    
    @cart.date_time_order_purchased
    @order_items = @cart.order_items
    
    @order_items.each do |order_item|
      product = order_item.product
      adjusting_quantity = order_item.quantity
      product.stock -= adjusting_quantity
      product.save
    end
    @cart.save
  end
  
  def show
    @order = Order.find_by(id: get_cart[:order_id])
    session[:order_id] = @order.id
  end
  
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

