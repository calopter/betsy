class OrderItemsController < ApplicationController
  def destroy
    get_cart.order_items.find{ |oi| oi.id == params[:id] }.delete
    redirect_to cart_path
  end
end
