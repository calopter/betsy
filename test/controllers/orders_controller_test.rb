require "test_helper"

describe OrdersController do
  describe 'show' do
    it 'responds with success when there is an existing cart' do
      add_to_cart
      get cart_path
      must_respond_with :success
    end

    it 'responds with success when there is not an existing cart' do
      get cart_path
      must_respond_with :success    
    end

    it 'always leaves order_id in session' do
      get cart_path
      assert Order.find_by(id: session[:order_id])
    end
  end

  describe 'add' do
    it 'sets the order status to pending and the order_item shipping status to pending' do
      add_to_cart

      order = Order.find_by(id: session[:order_id])

      expect(order.status).must_equal "pending"
      expect(order.order_items.first.shipping_status).must_equal "pending"
    end
    
    describe 'quantity > product stock' do
      it 'sets flash with error and redirects to product show' do
        product = products(:p_1)

        add_to_cart(product, product.stock.succ)

        expect(flash[:error]).must_equal "unable to add to cart"
        expect(flash[:messages]).must_equal({ quantity: ["can't be greater than what is currently in stock"] })
        
        must_respond_with :redirect
      end
    end
    
    describe 'empty cart' do
      it 'creates an order, adds the order item to it, and stores the order_id in session' do
        product = products(:p_1)
        OrderItem.delete_all
        Order.delete_all
        expect(Order.count).must_equal 0

        expect{ add_to_cart(product) }.must_change "Order.count", 1
        expect(OrderItem.count).must_equal 1

        order = Order.find_by(id: session[:order_id])
        
        assert order
        expect(order.id).must_equal Order.first.id
        expect(order.order_items.first.product).must_equal product
      end

      it 'sets flash to success and redirects' do
        product = add_to_cart
        expect(flash[:success]).must_equal "Added 1 #{ product.name } to cart"
        
        order = Order.find_by(id: session[:order_id])
        must_redirect_to cart_path
      end
    end

    describe 'existing order in cart' do
      it 'adds order item to the existing order from session' do
        add_to_cart
        assert session[:order_id]

        order = Order.find_by(id: session[:order_id])
        expect(order.order_items.count).must_equal 1

        add_to_cart products(:p_2)
        expect(order.order_items.count).must_equal 2
        expect(order.order_items.last.product).must_equal products(:p_2)
      end
    end
  end
end
