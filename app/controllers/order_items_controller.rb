class OrderItemsController < ApplicationController
  def destroy
    order_item = OrderItem.find_by(id: params[:id])
    if order_item && find_cart.order_items.include?(order_item)
      order_item.delete
      redirect_to cart_path
    else
      return head :not_found
    end
  end
end
