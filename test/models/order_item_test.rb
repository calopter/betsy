require "test_helper"

describe OrderItem do
  describe 'relations' do
    it 'has a product' do
      expect(OrderItem.new).must_respond_to :product
    end
    
    it 'has an order' do
      expect(OrderItem.new).must_respond_to :order
    end
  end
  
  describe 'custom methods' do
    describe 'total' do
      it 'returns an integer total price in cents' do
        prod = Product.create(price: 2)
        user = User.create
        order = Order.create(user_id: user.id)
        order_item = OrderItem.create(quantity: 2, product_id: prod.id, order_id: order.id)

        total = order_item.total
        expect(total).must_be_instance_of Integer
        expect(total).must_equal 4
      end
    end
  end
end
