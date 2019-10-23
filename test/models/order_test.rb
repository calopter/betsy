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
end
