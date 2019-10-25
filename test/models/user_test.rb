require "test_helper"

describe User do
  describe 'relations' do
    before do
      @user = User.new
    end
    
    it 'can have products' do
      @user.must_respond_to :products
    end

    it 'can have orders' do
      @user.must_respond_to :orders
    end

    it 'can have reviews' do
      @user.must_respond_to :reviews
    end
  end

  describe 'custom methods' do
    describe 'order_count' do
      it 'returns a hash of order count by status' do
        expect(users(:u_2).order_count).must_equal({ "paid" => 1, "complete" => 1 })
        expect(users(:u_1).order_count).must_equal({ "pending" => 2 })
      end
    end

    describe 'revenue' do
      it 'accurately sums the merchants revenue from all orders' do
        expect(users(:u_1).revenue).must_equal 315600
        # 9600 + 306000
      end

      it 'returns 0 if the merchant has no orders' do
        user = User.create
        expect(user.revenue).must_equal 0
      end
    end
  end
end
