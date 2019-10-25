require "test_helper"

describe OrderItem do
  describe 'relations' do
    it 'has an order' do
      expect(order_items(:o_i_1).order).must_equal orders(:o_2)
    end

    it 'has a product' do
      expect(order_items(:o_i_1).product).must_equal products(:p_1)
    end
  end
end
