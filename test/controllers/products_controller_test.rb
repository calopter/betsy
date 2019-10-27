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

      #VALIDATION TEST
      it "does not save and renders on new page when there is an invalid product submission" do
        product_hash = { product: { stock: 100, name: "Abu Jacket", description:"If the monkey wore it, I can wear it.", photo_url: "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/2845055508425", price: 50000, user_id: users(:u_1).id  }}
        
        expect {
        post products_path, params: product_hash
        }.must_differ 'Product.count', 0
      
        must_redirect_to product_path(Product.find_by(name: product_hash[:product][:name]))
      end
    end 
    

    describe "edit" do 
      it "brings up edit form with rendered information" do 
        get edit_product_path(id: products(:p_3).id)
        must_respond_with :success
      end 

      it "will send to not_found for invalid product_id" do
        get edit_product_path(id: -666)
        must_respond_with :not_found
      end
    end 

    describe "update" do 
      it "saves updated information to existing product, redirects, and doesn't change product count" do 
        updated_product_data = { product: { name: "Golden Scarab Beetle Mirrors", price: 700 } }
    
        expect { patch product_path(id: products(:p_2).id), params: updated_product_data }.must_differ 'Product.count', 0
    
        patch product_path(products(:p_2).id), params: updated_product_data
        updated_product = Product.find_by(id: products(:p_2).id)
        # binding.pry
        expect(updated_product.name).must_equal updated_product_data[:product][:name]
        expect(updated_product.price).must_equal updated_product_data[:product][:price]
        
        must_redirect_to product_path(products(:p_2).id)
      end 

      it "redirects to not_found if product id does not exist" do 
        patch product_path(-777), params: { product: { price: 700} }
        must_respond_with :not_found
      end 
    end 

    describe "destroy" do 
      it "removes product from db, redirects, and product count decreases" do 
        expect { delete product_path(products(:p_1).id) }.must_differ "Product.count", -1
        
        must_redirect_to products_path
      end 

      it "doesn't remove product if it's already removed or db is empty" do 
        Product.destroy_all
        delete product_path(products(:p_1).id)
        must_respond_with :not_found
        # expect { delete product_path(products(:p_1).id) }.must_differ "Product.count", 0
        # must_redirect_to products_path
      end 
    end 

    describe "rate_product" do 
      it "adds review to db, review count increases, and redirects" do
      end 

      #validation test
      it "does not save review if does not fill in correct information" do 
      end 
    end 
  end 

end
