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
  








  
  # describe "validations when created" do
  
  #   before do
  #     @order_hash = {
  #       order: {
  #         status: "pending",
  #         user_id: User.first.id,
  #         id: 1111
  #       },
  #     }
  #   end
  
  #   it "requires a user" do
  #     @order_hash[:order][:user_id] = nil
  
  #     order = Order.new
  #     order.user_id = nil
  #     order.status = "pending"
  
  #     assert_not(order.valid?)      
  #   end
  
  #   # it "requires initial has status at creation" do 
  #   #   order = Order.new
  #   #   order.user_id = @order_hash[:order][:user_id]
  #   #   assert_not(order.valid?)  
  #   # end 
  
  #   it "requires initial status" do
  #     @order_hash[:order][:status] = nil
  #     order = Order.new
  #     order.user_id = @order_hash[:order][:user_id]
  #     order.status = nil
  
  #     assert_not(order.valid?)
  #   end
  
  # end
  
  # describe "validations when paying" do
  
  #   before do
  #     @order = orders(:o_2)
  #     @user = User.find_by(id: @order.user_id)
  
  #   end
  
  #   it "when paying, user email is necessary" do
  #     @user.email = ""
  #     assert_not(@order.valid?)
  #   end
  
  #   it "when paying, user street address is necessary" do
  #     @user.street_address = ""
  #     assert_not(@order.valid?)
  #   end
  
  #   # it "when paying, user email must have the necessary parts" do
  #   #   @user.street_address = "I_am_not_an_email"
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   # it "when paying, user email must not have spaces" do
  #   #   @user.street_address = "I_am_not an_email@gmail.com"
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   # it "when paying, user email address is valid if it has the symbol and then has characters before and after it" do
  #   #   @user.city = "someone@somewhere.com"
  #   #   assert(@order.valid?)
  #   # end
  
  #   it "when paying, mailing address state is necessary" do
  #     @user.state = ""
  #     assert_not(@order.valid?)
  #   end
  
  #   it "when paying, mailing address state must be a string" do
  #     @user.state = 32978
  #     assert_not(@order.valid?)
  #   end
  
  #   it "when paying, mailing address state must have 2 letters" do
  #     @user.state = "great"
  #     assert_not(@order.valid?)
  #   end
  
  #   # it "when paying, mailing address state cannot have special characters" do
  #   #   @user.state = "o."
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   # it "when paying, user mailing address state is valid if it's made up of 2 letters" do
  #   #   @user.city = "AA"
  #   #   assert(@order.valid?)
  #   # end
  
  #   it "when paying, mailing address city is necessary" do
  #     @user.city = ""
  #     assert_not(@order.valid?)
  #   end
  
  #   it "when paying, user mailing address city is valid if it's made up of something" do
  #     @user.city = "Los Angeles"
  #     assert(@order.valid?)
  #   end
  
  #   it "when paying, mailing address zip code is necessary" do
  #     @user.mailing_zip = nil
  #     assert_not(@order.valid?)
  #   end
  
  #   it "when paying, though a string mailing address zip code must have 5 characters" do
  #     @user.mailing_zip = "989789789"
  #     assert_not(@order.valid?)
  #   end
  
  #   # it "when paying, though a string, mailing address zip code must be made up of numbers" do
  #   #   @user.mailing_zip = "aaaaa"
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   # it "when paying, though a string, mailing address zip code must be made up of numbers" do
  #   #   @user.mailing_zip = "08.89"
  #   #   assert_not(@order.valid?)
  #   # end
  
  
  #   it "when paying, user mailing address zip is valid if it's made up of 5 numbers" do
  #     @user.mailing_zip = "08880"
  #     assert(@order.valid?)
  #   end
  
  #   it "when paying, mailing address zip code is necessary" do
  #     @user.billing_zip = nil
  #     assert_not(@order.valid?)
  #   end
  
  #   it "when paying, though a string mailing address zip code must have 5 characters" do
  #     @user.billing_zip = "989789789"
  #     assert_not(@order.valid?)
  #   end
  
  #   # it "when paying, though a string, mailing address zip code must be made up of numbers" do
  #   #   @user.billing_zip = "aaaaa"
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   # it "when paying, though a string, billing address zip code must be made up of numbers" do
  #   #   @user.billing_zip = "08.89"
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   it "when paying, user mailing address zip is valid if it's made up of 5 numbers" do
  #     @user.billing_zip = "08880"
  #     assert(@order.valid?)
  
  #   end
  
  #   it "when paying, user credit card name is necessary " do
  #     @user.cc_name = ""
  #     assert_not(@order.valid?)
  #   end
  
  #   it "when paying, user credit card name is valid if it's made up of something" do
  #     @user.cc_name = "Great Company"
  #     assert(@order.valid?)
  #   end
  
  #   it "when paying, user credit card number must be 16 characters long " do
  #     @user.cc_number = "11112222333344445"
  #     assert_not(@order.valid?)
  #   end
  
  #   # it "when paying, user credit card number must not include special characters " do
  #   #   @user.cc_number = "1111.222.333.444"
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   # it "when paying, user credit card number must not include letters " do
  #   #   @user.cc_number = "1111a222b333c444"
  #   #   assert_not(@order.valid?)
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
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   # it "when paying, a user credit card expiration date must not have letters" do
  #   #   @user.cc_expiration = "11i1"
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   it "when paying, a user credit card expiration date must have 4 characters" do
  #     @user.cc_expiration = "11223"
  #     binding.pry
  #     assert_not(@order.valid?)
  #   end
  
  #   it "when paying, a user credit card verification value must have 3 characters" do
  #     @user.cvv = "1122"
  #     assert_not(@order.valid?)
  #   end
  
  
  #   it "when paying, a user credit card verification value must be made up of 3 numbers" do
  #     @user.cvv = "925"
  #     assert(@order.valid?)
  #   end
  
  #   # it "when paying, a user credit card verification value must not have letters" do
  #   #   @user.cvv = "78q"
  #   #   assert_not(@order.valid?)
  #   # end
  
  #   # it "when paying, a user credit card verification value must not have spaces" do
  #   #   @user.cvv = "7 8"
  #   #   assert_not(@order.valid?)
  #   # end
  
  # end
  
  # describe "validations during editing / at any time" do
  #   before do
  #     @order = orders(:o_2)
  #   end
  
  #   it "valid status are only pending, paid, complete or cancelled" do
  #     @order.status = "working on it"
  #     assert_not(@order.valid?)
  #   end
  
  #   it "valid status are only pending, paid, complete or cancelled" do
  #     @order.status = "paid"
  
  #     assert(@order.valid?)
  #   end
  
  # end
  
  
end
