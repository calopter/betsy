require "test_helper"

describe ProductsController do

  describe "index" do 
    it "shows all products saved and page showed successfully" do
      get products_path
      must_respond_with :success
    end

    it "even if there are no products saved but index succesfully shows" do
      Product.destroy_all
      get products_path
      must_respond_with :success
    end
  end 

  describe "show" do 
    it "responds with success when showing a valid product" do
      product = products(:p_1)
      get product_path(product.id)
      must_respond_with :success

      expect(product.name).must_equal "ADULT RED FEZ HAT"
      expect(product.price).must_equal 20000
    end
    
    it "responds with 404 with an invalid product id" do
      get product_path(777)
      must_respond_with :not_found
    end

    describe "new" do
      it "responds with success" do
        get new_product_path
        must_respond_with :success
      end
    end

    describe "create" do 
      it "can create a new product with valid information accurately, and redirect" do
        product_hash = { product: { stock: 100, name: "Abu Jacket", description: "If the monkey wore it, I can wear it.", photo_url: "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/2845055508425", price: 50000, user_id: users(:u_1).id }}

        
        expect {
        post products_path, params: product_hash
        }.must_differ 'Product.count', 1
      
        must_redirect_to product_path(Product.find_by(name: product_hash[:product][:name]))
      end

      #NEED VALIDATIONS
      it "does not save and renders on new page when there is an invalid product submission" do
        product_hash = { product: { stock: 100, name: "Abu Jacket", description:"If the monkey wore it, I can wear it.", photo_url: "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/2845055508425", price: 50000, user_id: users(:u_1).id  }}
        
        expect {
        post products_path, params: product_hash
        }.must_differ 'Product.count', 0
      
        must_redirect_to product_path(Product.find_by(name: product_hash[:product][:name]))
      end
    end 
    
  end 

end
