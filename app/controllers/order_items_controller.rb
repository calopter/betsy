class OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find_by(id: params[:id])
    
    if find_cart.order_items.include?(order_item)
      order_item.quantity = order_item_params[:quantity]
      order_item.save
      flash[:success] = "updated #{ order_item.product.name } quantity"
      redirect_to cart_path
    else
      flash[:error] = "unable to update quantity"
      redirect_to cart_path
    end
  end
  
  def destroy
    order_item = OrderItem.find_by(id: params[:id])
    if order_item && find_cart.order_items.include?(order_item)
      order_item.delete
      flash[:success] = "removed #{ order_item.product.name }"
      redirect_to cart_path
    else
      flash[:error] = "unable to remove #{ order_item.product.name }"
      flash[:messages] = ["not found"]
      return head :not_found
    end
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end
