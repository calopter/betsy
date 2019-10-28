require "test_helper"

describe OrdersController do
  describe "complete_purchase" do
    before do
      @order = orders(:o_1)
      @user = User.find_by(id: @order.user_id)
    end
    
    it "completing a purchase changes an order's status" do
      expected_order_status = "paid"
      @order.status = "pending"
      
      post orders_purchase_confirmation_path(@order.id)
      
      expect(@order.status).must_equal expected_order_status
      
    end
    
    it "completing a purchase adjusts the stock amount for related products" do
      #finds products associated with order
      # @order = 
      @products = Product.where(id: OrderItem.find_by(order_id: @order.id).product_id)
      
      special = @products.first
      special.stock = 100
     
      post orders_purchase_confirmation_path(@order.id)
      
      expect(special.stock).must_equal 4
    end
    
    
    it "if a purchase is not being made, validations needed for purchase such as email, cc information etc. are not being run" do
      user = User.first
      user.email = ""
      order = Order.first
      order.user_id = user.id
      order.status = "pending"
      assert(user.valid?)
    end
    
    it "if a purchase is being made, validations needed are being run" do
      user = User.first
      user.email = ""
      order = Order.first
      order.user_id = user.id
      
      post orders_purchase_confirmation_path(order.id)
      
      must_redirect_to root_path
      binding.pry
    end
    
  end
  
end
