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
  
  
  describe "validations when created" do
    
    before do
      @order_hash = {
        order: {
          status: "pending",
          user_id: User.first.id,
          id: 1111
        },
      }
    end
    
    it "requires a user" do
      order = Order.new
      order.user_id = nil
      order.status = "pending"
      # binding.pry
      refute(order.valid?)      
    end
    
    it "requires initial has status at creation" do 
      order = Order.new
      order.user_id = 111
      refute(order.valid?)  
    end 
    
    it "status can only be pending, paid, complete or cancelled" do 
      order = Order.first
      order.status = "working on it"
      refute(order.valid?)
    end
    
    it "valid status are only pending, paid, complete or cancelled" do
      order = Order.first
      assert(order.valid?)
    end
    
  end
  
  describe "validations when paying" do
    before do
      @order = Order.last
      @user = User.find_by(id: @order.user_id)
    end
    it "when paying, meething the minimum of 1 order is necessary" do
      assert(@order.valid?)
    end
    it "when not paying, the minimum order items is ignored" do
      OrderItem.destroy_all
      @order.status = "pending"
      assert(@order.valid?)
    end
    it "when not paying, the minimum order items is enforced" do
      OrderItem.destroy_all
      @order.status = "paid"
      refute(@order.valid?)
    end
  end
  describe "destruction test" do
    it "checks if destruction stuck" do
      expect(OrderItem.count).must_equal 20
    end
  end
  
  
  # it "when paying, user email is necessary" do
  #   @user.email = ""
  #   refute(@order.valid?)
  # end
  
  #   it "when paying, user street address is necessary" do
  #     @user.street_address = ""
  #     refute(@order.valid?)
  #   end
  
  #   # it "when paying, user email must have the necessary parts" do
  #   #   @user.street_address = "I_am_not_an_email"
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, user email must not have spaces" do
  #   #   @user.street_address = "I_am_not an_email@gmail.com"
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, user email address is valid if it has the symbol and then has characters before and after it" do
  #   #   @user.city = "someone@somewhere.com"
  #   #   assert(@order.valid?)
  #   # end
  
  #   it "when paying, mailing address state is necessary" do
  #     @user.state = ""
  #     refute(@order.valid?)
  #   end
  
  #   it "when paying, mailing address state must be a string" do
  #     @user.state = 32978
  #     refute(@order.valid?)
  #   end
  
  #   it "when paying, mailing address state must have 2 letters" do
  #     @user.state = "great"
  #     refute(@order.valid?)
  #   end
  
  #   # it "when paying, mailing address state cannot have special characters" do
  #   #   @user.state = "o."
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, user mailing address state is valid if it's made up of 2 letters" do
  #   #   @user.city = "AA"
  #   #   assert(@order.valid?)
  #   # end
  
  #   it "when paying, mailing address city is necessary" do
  #     @user.city = ""
  #     refute(@order.valid?)
  #   end
  
  #   it "when paying, user mailing address city is valid if it's made up of something" do
  #     @user.city = "Los Angeles"
  #     assert(@order.valid?)
  #   end
  
  #   it "when paying, mailing address zip code is necessary" do
  #     @user.mailing_zip = nil
  #     refute(@order.valid?)
  #   end
  
  #   it "when paying, though a string mailing address zip code must have 5 characters" do
  #     @user.mailing_zip = "989789789"
  #     refute(@order.valid?)
  #   end
  
  #   # it "when paying, though a string, mailing address zip code must be made up of numbers" do
  #   #   @user.mailing_zip = "aaaaa"
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, though a string, mailing address zip code must be made up of numbers" do
  #   #   @user.mailing_zip = "08.89"
  #   #   refute(@order.valid?)
  #   # end
  
  
  #   it "when paying, user mailing address zip is valid if it's made up of 5 numbers" do
  #     @user.mailing_zip = "08880"
  #     assert(@order.valid?)
  #   end
  
  #   it "when paying, mailing address zip code is necessary" do
  #     @user.billing_zip = nil
  #     refute(@order.valid?)
  #   end
  
  #   it "when paying, though a string mailing address zip code must have 5 characters" do
  #     @user.billing_zip = "989789789"
  #     refute(@order.valid?)
  #   end
  
  #   # it "when paying, though a string, mailing address zip code must be made up of numbers" do
  #   #   @user.billing_zip = "aaaaa"
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, though a string, billing address zip code must be made up of numbers" do
  #   #   @user.billing_zip = "08.89"
  #   #   refute(@order.valid?)
  #   # end
  
  #   it "when paying, user mailing address zip is valid if it's made up of 5 numbers" do
  #     @user.billing_zip = "08880"
  #     assert(@order.valid?)
  
  #   end
  
  #   it "when paying, user credit card name is necessary " do
  #     @user.cc_name = ""
  #     refute(@order.valid?)
  #   end
  
  #   it "when paying, user credit card name is valid if it's made up of something" do
  #     @user.cc_name = "Great Company"
  #     assert(@order.valid?)
  #   end
  
  #   it "when paying, user credit card number must be 16 characters long " do
  #     @user.cc_number = "11112222333344445"
  #     refute(@order.valid?)
  #   end
  
  #   # it "when paying, user credit card number must not include special characters " do
  #   #   @user.cc_number = "1111.222.333.444"
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, user credit card number must not include letters " do
  #   #   @user.cc_number = "1111a222b333c444"
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, user credit card number must not include letters " do
  #   #   @user.cc_number = "1111222233334444"
  #   #   assert(@order.valid?)
  #   # end
  
  #   it "when paying, a user credit card expiration date must be 2 digit year and 2 digit month" do
  #     @user.cc_expiration = "1121"
  #     assert(@order.valid?)
  #   end
  
  #   # it "when paying, a user credit card expiration date must not have spaces" do
  #   #   @user.cc_expiration = "11 3"
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, a user credit card expiration date must not have letters" do
  #   #   @user.cc_expiration = "11i1"
  #   #   refute(@order.valid?)
  #   # end
  
  #   it "when paying, a user credit card expiration date must have 4 characters" do
  #     @user.cc_expiration = "11223"
  #     binding.pry
  #     refute(@order.valid?)
  #   end
  
  #   it "when paying, a user credit card verification value must have 3 characters" do
  #     @user.cvv = "1122"
  #     refute(@order.valid?)
  #   end
  
  
  #   it "when paying, a user credit card verification value must be made up of 3 numbers" do
  #     @user.cvv = "925"
  #     assert(@order.valid?)
  #   end
  
  #   # it "when paying, a user credit card verification value must not have letters" do
  #   #   @user.cvv = "78q"
  #   #   refute(@order.valid?)
  #   # end
  
  #   # it "when paying, a user credit card verification value must not have spaces" do
  #   #   @user.cvv = "7 8"
  #   #   refute(@order.valid?)
  #   # end
  
  # end
  
  # describe "validations during editing / at any time" do
  #   before do
  #     @order = orders(:o_2)
  #   end
  
  #   it "valid status are only pending, paid, complete or cancelled" do
  #     @order.status = "working on it"
  #     refute(@order.valid?)
  #   end
  
  #   it "valid status are only pending, paid, complete or cancelled" do
  #     @order.status = "paid"
  
  #     assert(@order.valid?)
  #   end
  
  # end
end