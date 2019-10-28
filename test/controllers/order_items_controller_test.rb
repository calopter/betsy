require "test_helper"

describe OrderItemsController do
  describe 'update' do
    
  end

  describe 'destroy' do
    it 'removes existing order_item from the cart and db, then redirects' do
      
      add_to_cart
      expect(find_cart.order_items.count).must_equal 1

      order_item = @cart.order_items.first

      expect{ delete remove_from_cart_path(order_item) }.must_change "@cart.order_items.count", -1
    end

    it 'responds with bad request for non-existing order item' do
      add_to_cart

      expect{ delete remove_from_cart_path(order_items(:o_i_1)) }.wont_change "@cart.order_items.count"
      
      delete remove_from_cart_path(order_items(:o_i_1))
      must_respond_with :not_found
    end
    
    it 'responds with bad request for non-existing cart' do
      delete remove_from_cart_path(order_items(:o_i_1))
      must_respond_with :not_found
    end
  end
end
