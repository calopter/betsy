require "test_helper"

describe CategoryController do 
  describe "index action" do 
    it "display a successful message" do 
      get category_path must_respond_with: success 
    end 
    it "display success if there are no categories available" do 
      get category_path must_respond_with: success 
    end 
  end 
  describe "create action" do 
    
    
    it "if there is no input, should not let the guest create a new category" do 
      post categories_path, params: {
      category: {
      name: "new category"
      }
      } 
        expect(flash[:result_text]).must_equal "Must log in"
      must_redirect_to root_path 
    end 

    
    it "guest user cannot create a new category" do 
      category_hash = {
      category: {
        label: "Shoes"
        }
      } 
      expect(post categories_path, params: category_hash).must_differ "Category.count", 0 
      expect(flash[:result_text]).must_equal "You must login" 
        must_redirect_to root_path 
    end 

    
    it "Merchant can create a new  category" do 
      perform_login category_hash = {
      category: {
        label: "Jewellary"
      }
    }
    expect(
      post categories_path, params: category_hash
    ).must_differ "Category.count", 1 
    must_redirect_to root_path 
    end 
  end 
end