require "test_helper"

describe OrdersController do
  describe 'add' do
    it 'sets the correct product' do
      product = products(:p_1)
      
      post add_to_cart_path(product.id)

      order_id = session[:order_id]

      order = Order.find_by(id: order_id)

      expect(order.order_items.first.product).must_equal product
    end

    it 'sets the shipping status to pending' do
      
    end
    
    describe 'quantity > product stock' do
      it 'sets flash with error and redirects to product show' do
        
      end
    end
    
    describe 'empty cart' do
      it 'creates an order, adds the order item to it, and stores the order_id in session' do
        
      end

      it 'sets flash to success and redirects' do
        
      end
    end

    describe 'existing order in cart' do
      it 'adds order item to the existing order from session' do
        
      end
      
      it 'sets flash to success and redirects' do
        
      end
    end
  end
end
