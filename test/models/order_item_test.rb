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

      end
    end
  end
end
