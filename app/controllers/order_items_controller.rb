class OrderItemsController < ApplicationController
  def destroy
    OrderItem.find_by(id: params[:id]).delete
    redirect_to cart_path
  end
end
