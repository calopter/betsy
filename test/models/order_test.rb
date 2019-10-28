require "test_helper"

describe Order do
  describe 'relations' do
    it 'has_many order_items' do
      expect(Order.new).must_respond_to :order_items
    end

    it 'has a user' do
      expect(Order.new).must_respond_to :user
    end
  end

  describe 'custom methods' do
    describe 'revenue' do
      it 'returns an accurate total cost of all order items' do
        expect(orders(:o_1).revenue).must_equal 9600
        # 100 * 90 + 100 * 6
      end
    end
  end
end
